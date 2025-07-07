# 📋 Documentación Técnica - Retrolector

## 🏗️ Arquitectura del Sistema

### Patrón MVC (Model-View-Controller)
El proyecto sigue el patrón MVC de Laravel:

```
app/
├── Http/Controllers/     # Controladores
├── Models/              # Modelos Eloquent
├── Http/Middleware/     # Middleware personalizado
└── Providers/          # Proveedores de servicios

resources/
├── views/              # Vistas Blade
├── css/               # Estilos CSS
└── js/                # JavaScript

database/
├── migrations/         # Migraciones de BD
├── seeders/           # Seeders de datos
└── factories/         # Factories para testing
```

## 🗄️ Estructura de Base de Datos

### Diagrama ER (Entidad-Relación)

```
usuarios (1) ──── (N) prestamos
usuarios (1) ──── (N) reservas
usuarios (1) ──── (N) compras
usuarios (1) ──── (N) favoritos
usuarios (1) ──── (N) resenas
usuarios (1) ──── (N) notificaciones

libros (1) ──── (N) prestamos
libros (1) ──── (N) reservas
libros (1) ──── (N) compras
libros (1) ──── (N) favoritos
libros (1) ──── (N) resenas

autors (1) ──── (N) libros
categorias (1) ──── (N) libros
```

### Tablas Principales

#### usuarios
- `id` (PK, auto-increment)
- `nombre`, `apellido`, `email`, `password`
- `rol` (enum: 'cliente', 'admin')
- `email_verified_at`, `remember_token`
- `created_at`, `updated_at`

#### libros
- `id` (PK, auto-increment)
- `titulo`, `descripcion`, `isbn`
- `precio_compra_fisica`, `precio_compra_online`
- `precio_prestamo_fisico`, `precio_prestamo_online`
- `stock_fisico`, `stock_online`
- `portada`, `archivo_pdf`, `contenido`
- `preview_limit`, `ubicacion`
- `autor_id`, `categoria_id`, `creado_por`
- `vistas`, `created_at`, `updated_at`

#### prestamos
- `id` (PK, auto-increment)
- `usuario_id`, `libro_id`
- `fecha_prestamo`, `fecha_devolucion`
- `tipo` (enum: 'fisico', 'online')
- `estado` (enum: 'activo', 'devuelto', 'vencido')
- `created_at`, `updated_at`

## 🔐 Sistema de Autenticación

### Middleware Personalizado

#### AdminMiddleware
```php
// Verifica que el usuario sea administrador
if (auth()->check() && auth()->user()->rol === 'admin') {
    return $next($request);
}
```

#### ClienteMiddleware
```php
// Verifica que el usuario sea cliente
if (auth()->check() && auth()->user()->rol === 'cliente') {
    return $next($request);
}
```

### Rutas Protegidas
```php
// Rutas de administrador
Route::middleware(['auth', 'admin'])->group(function () {
    Route::get('/admin/dashboard', [AdminController::class, 'dashboard']);
    Route::resource('/admin/books', AdminBookController::class);
});

// Rutas de cliente
Route::middleware(['auth', 'cliente'])->group(function () {
    Route::get('/user/dashboard', [UserController::class, 'dashboard']);
    Route::resource('/user/loans', LoanController::class);
});
```

## 📊 Modelos Eloquent

### Relaciones Principales

#### Usuario
```php
public function prestamos() {
    return $this->hasMany(Prestamo::class);
}

public function reservas() {
    return $this->hasMany(Reserva::class);
}

public function favoritos() {
    return $this->hasMany(Favorito::class);
}
```

#### Libro
```php
public function autor() {
    return $this->belongsTo(Autor::class);
}

public function categoria() {
    return $this->belongsTo(Categoria::class);
}

public function prestamos() {
    return $this->hasMany(Prestamo::class);
}
```

## 🎨 Sistema de Vistas

### Layout Principal
```blade
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', 'Retrolector')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body>
    @include('components.navigation')
    <main>
        @yield('content')
    </main>
    @include('components.footer')
</body>
</html>
```

### Componentes Reutilizables
- `navigation.blade.php` - Navegación principal
- `book-card.blade.php` - Tarjeta de libro
- `pagination.blade.php` - Paginación
- `alert.blade.php` - Alertas del sistema

## 🔧 Configuración del Sistema

### Variables de Entorno (.env)
```env
APP_NAME=Retrolector
APP_ENV=production
APP_KEY=base64:...
APP_DEBUG=false
APP_URL=https://retrolector.com

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=retrolector
DB_USERNAME=usuario
DB_PASSWORD=contraseña

MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=notificaciones@retrolector.com
MAIL_PASSWORD=app_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=notificaciones@retrolector.com
MAIL_FROM_NAME="${APP_NAME}"

FILESYSTEM_DISK=public
```

### Configuración de Archivos
```php
// config/filesystems.php
'disks' => [
    'public' => [
        'driver' => 'local',
        'root' => storage_path('app/public'),
        'url' => env('APP_URL').'/storage',
        'visibility' => 'public',
    ],
],
```

## 📱 API Endpoints (Futuro)

### Autenticación
```
POST /api/auth/login
POST /api/auth/register
POST /api/auth/logout
GET  /api/auth/user
```

### Libros
```
GET    /api/books              # Listar libros
GET    /api/books/{id}         # Obtener libro
POST   /api/books              # Crear libro (admin)
PUT    /api/books/{id}         # Actualizar libro (admin)
DELETE /api/books/{id}         # Eliminar libro (admin)
```

### Préstamos
```
GET    /api/loans              # Listar préstamos del usuario
POST   /api/loans              # Crear préstamo
PUT    /api/loans/{id}/return  # Devolver préstamo
```

## 🧪 Testing

### Estructura de Tests
```
tests/
├── Feature/           # Tests de integración
│   ├── BookTest.php
│   ├── LoanTest.php
│   └── UserTest.php
└── Unit/             # Tests unitarios
    ├── BookTest.php
    └── UserTest.php
```

### Ejemplo de Test
```php
class BookTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_view_book_catalog()
    {
        $user = User::factory()->create(['rol' => 'cliente']);
        $book = Book::factory()->create();

        $response = $this->actingAs($user)
                        ->get('/books/catalog');

        $response->assertStatus(200);
        $response->assertSee($book->titulo);
    }
}
```

## 🚀 Optimización y Rendimiento

### Caché
```php
// Cache de consultas frecuentes
$books = Cache::remember('books.catalog', 3600, function () {
    return Book::with(['autor', 'categoria'])->paginate(12);
});
```

### Consultas Optimizadas
```php
// Eager loading para evitar N+1 queries
$books = Book::with(['autor', 'categoria', 'resenas'])
    ->where('stock_fisico', '>', 0)
    ->orWhere('stock_online', '>', 0)
    ->paginate(12);
```

### Índices de Base de Datos
```sql
-- Índices para optimizar búsquedas
CREATE INDEX idx_libros_titulo ON libros(titulo);
CREATE INDEX idx_libros_autor_id ON libros(autor_id);
CREATE INDEX idx_libros_categoria_id ON libros(categoria_id);
CREATE INDEX idx_prestamos_usuario_id ON prestamos(usuario_id);
CREATE INDEX idx_prestamos_libro_id ON prestamos(libro_id);
```

## 🔒 Seguridad

### Validación de Formularios
```php
public function store(Request $request)
{
    $validated = $request->validate([
        'titulo' => 'required|string|max:255',
        'descripcion' => 'required|string',
        'isbn' => 'required|string|unique:libros',
        'precio_compra_fisica' => 'required|numeric|min:0',
        'stock_fisico' => 'required|integer|min:0',
        'portada' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        'archivo_pdf' => 'nullable|file|mimes:pdf|max:10240',
    ]);
}
```

### Sanitización de Datos
```php
// Sanitización automática en modelos
protected $fillable = [
    'titulo', 'descripcion', 'isbn', 'precio_compra_fisica'
];

// Mutators para formateo automático
public function setTituloAttribute($value)
{
    $this->attributes['titulo'] = ucfirst(strtolower(trim($value)));
}
```

## 📈 Monitoreo y Logs

### Logging Personalizado
```php
// Log de acciones importantes
Log::info('Nuevo préstamo creado', [
    'usuario_id' => $user->id,
    'libro_id' => $book->id,
    'tipo' => $tipo,
    'ip' => request()->ip()
]);
```

### Métricas de Rendimiento
```php
// Contador de vistas
public function incrementViews()
{
    $this->increment('vistas');
    Cache::forget('books.catalog');
}
```

## 🔄 Comandos Artisan

### Comandos Personalizados
```php
// Comando para marcar préstamos vencidos
php artisan loans:mark-overdue

// Comando para generar reportes
php artisan reports:generate

// Comando para limpiar archivos temporales
php artisan storage:cleanup
```

## 📦 Despliegue

### Requisitos de Producción
- **Servidor**: Ubuntu 20.04+ / CentOS 8+
- **PHP**: 8.2+ con extensiones requeridas
- **MySQL**: 8.0+ o MariaDB 10.5+
- **Nginx**: 1.18+ o Apache 2.4+
- **SSL**: Certificado válido (Let's Encrypt)

### Script de Despliegue
```bash
#!/bin/bash
# deploy.sh

# Pull latest changes
git pull origin main

# Install dependencies
composer install --no-dev --optimize-autoloader
npm install
npm run build

# Run migrations
php artisan migrate --force

# Clear caches
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# Set permissions
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

# Restart services
sudo systemctl restart nginx
sudo systemctl restart php8.2-fpm
```

## 🐛 Debugging

### Herramientas de Debug
- **Laravel Debugbar** (desarrollo)
- **Laravel Telescope** (monitoreo)
- **Logs de Laravel** (`storage/logs/laravel.log`)

### Comandos de Debug
```bash
# Ver logs en tiempo real
tail -f storage/logs/laravel.log

# Ver configuración actual
php artisan config:show

# Ver rutas registradas
php artisan route:list

# Ver estado de la aplicación
php artisan about
```

---

Esta documentación técnica proporciona una visión completa de la arquitectura, configuración y desarrollo del sistema Retrolector. Para más detalles específicos, consulta los archivos de código fuente y la documentación de Laravel. 