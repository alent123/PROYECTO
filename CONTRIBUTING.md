# 🤝 Guía de Contribución

¡Gracias por tu interés en contribuir al proyecto **Retrolector**! Este documento proporciona las pautas necesarias para contribuir al desarrollo del sistema.

## 📋 Tabla de Contenidos

- [Cómo Contribuir](#cómo-contribuir)
- [Configuración del Entorno](#configuración-del-entorno)
- [Estándares de Código](#estándares-de-código)
- [Proceso de Pull Request](#proceso-de-pull-request)
- [Reporte de Bugs](#reporte-de-bugs)
- [Solicitud de Funcionalidades](#solicitud-de-funcionalidades)
- [Preguntas Frecuentes](#preguntas-frecuentes)

## 🚀 Cómo Contribuir

### Tipos de Contribuciones

Aceptamos los siguientes tipos de contribuciones:

- 🐛 **Reporte de bugs** - Ayúdanos a encontrar y arreglar problemas
- 💡 **Solicitud de funcionalidades** - Sugiere nuevas características
- 📝 **Mejoras en documentación** - Ayuda a mejorar la documentación
- 🔧 **Mejoras en código** - Optimiza el código existente
- ✨ **Nuevas funcionalidades** - Implementa nuevas características
- 🧪 **Tests** - Añade o mejora tests existentes

## 🛠️ Configuración del Entorno

### Prerrequisitos

- **PHP**: 8.2 o superior
- **Composer**: Última versión estable
- **MySQL**: 8.0 o superior
- **Node.js**: 16+ (para compilación de assets)
- **Git**: Última versión estable

### Configuración Local

1. **Fork el repositorio**
   ```bash
   # Ve a GitHub y haz fork del repositorio
   # Luego clona tu fork
   git clone https://github.com/TU_USUARIO/PROYECTO.git
   cd PROYECTO
   ```

2. **Configura el entorno de desarrollo**
   ```bash
   cd retrolector
   composer install
   npm install
   cp .env.example .env
   php artisan key:generate
   ```

3. **Configura la base de datos**
   ```bash
   # Crea una base de datos local
   mysql -u root -p
   CREATE DATABASE retrolector_dev;
   
   # Configura .env
   DB_DATABASE=retrolector_dev
   DB_USERNAME=tu_usuario
   DB_PASSWORD=tu_contraseña
   
   # Ejecuta migraciones
   php artisan migrate
   php artisan db:seed
   ```

4. **Configura el servidor de desarrollo**
   ```bash
   php artisan serve
   npm run dev
   ```

## 📏 Estándares de Código

### PHP (PSR-12)

Seguimos los estándares PSR-12 para PHP:

```php
<?php

declare(strict_types=1);

namespace App\Http\Controllers;

use App\Models\Book;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class BookController extends Controller
{
    public function index(): Response
    {
        $books = Book::with(['autor', 'categoria'])
            ->paginate(12);

        return response()->view('books.index', compact('books'));
    }
}
```

### JavaScript (ES6+)

```javascript
// Usar const/let en lugar de var
const books = [];
let currentPage = 1;

// Arrow functions
const fetchBooks = async () => {
    try {
        const response = await fetch('/api/books');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching books:', error);
        throw error;
    }
};

// Template literals
const message = `Libro ${book.title} añadido a favoritos`;
```

### CSS (BEM Methodology)

```css
/* Block */
.book-card {
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 1rem;
}

/* Element */
.book-card__title {
    font-size: 1.2rem;
    font-weight: bold;
    margin-bottom: 0.5rem;
}

/* Modifier */
.book-card--featured {
    border-color: #007bff;
    background-color: #f8f9fa;
}
```

### Nomenclatura

#### Archivos y Directorios
- **Controllers**: PascalCase (`BookController.php`)
- **Models**: PascalCase (`Book.php`)
- **Views**: kebab-case (`book-show.blade.php`)
- **Migrations**: snake_case (`create_books_table.php`)

#### Variables y Funciones
- **Variables**: camelCase (`$bookTitle`)
- **Funciones**: camelCase (`getBookDetails()`)
- **Constantes**: UPPER_SNAKE_CASE (`MAX_BOOKS_PER_PAGE`)
- **Clases**: PascalCase (`BookController`)

## 🔄 Proceso de Pull Request

### 1. Crear una Rama

```bash
# Asegúrate de estar en main y actualizado
git checkout main
git pull origin main

# Crea una nueva rama
git checkout -b feature/nueva-funcionalidad
# o
git checkout -b fix/correccion-bug
```

### 2. Hacer Cambios

```bash
# Haz tus cambios en el código
# Asegúrate de seguir los estándares de código

# Añade archivos modificados
git add .

# Haz commit con mensaje descriptivo
git commit -m "feat: añadir sistema de búsqueda avanzada

- Implementar filtros por categoría y autor
- Añadir búsqueda por ISBN
- Optimizar consultas de base de datos
- Añadir tests unitarios"
```

### 3. Push y Pull Request

```bash
# Push a tu fork
git push origin feature/nueva-funcionalidad

# Ve a GitHub y crea un Pull Request
```

### 4. Plantilla de Pull Request

```markdown
## 📝 Descripción

Breve descripción de los cambios realizados.

## 🎯 Tipo de Cambio

- [ ] Bug fix (corrección de bug)
- [ ] New feature (nueva funcionalidad)
- [ ] Breaking change (cambio que rompe compatibilidad)
- [ ] Documentation update (actualización de documentación)

## 🧪 Tests

- [ ] Tests unitarios añadidos/actualizados
- [ ] Tests de integración añadidos/actualizados
- [ ] Tests manuales realizados

## 📋 Checklist

- [ ] Mi código sigue los estándares de estilo del proyecto
- [ ] He realizado una auto-revisión de mi código
- [ ] He comentado mi código, especialmente en áreas difíciles de entender
- [ ] He hecho los cambios correspondientes en la documentación
- [ ] Mis cambios no generan nuevos warnings
- [ ] He añadido tests que prueban que mi corrección funciona
- [ ] Todos los tests nuevos y existentes pasan

## 📸 Screenshots (si aplica)

Añade screenshots si los cambios afectan la interfaz de usuario.

## 🔗 Issues Relacionados

Closes #123
```

## 🐛 Reporte de Bugs

### Plantilla de Bug Report

```markdown
## 🐛 Descripción del Bug

Descripción clara y concisa del bug.

## 🔄 Pasos para Reproducir

1. Ve a '...'
2. Haz clic en '...'
3. Desplázate hacia abajo hasta '...'
4. Ve el error

## ✅ Comportamiento Esperado

Descripción clara de lo que debería pasar.

## 📸 Screenshots

Si aplica, añade screenshots para ayudar a explicar el problema.

## 💻 Información del Sistema

- **OS**: [ej. Windows 10, macOS 12.0]
- **Navegador**: [ej. Chrome 90, Firefox 88]
- **Versión**: [ej. 1.0.0]

## 📋 Información Adicional

Cualquier otra información sobre el problema.
```

## 💡 Solicitud de Funcionalidades

### Plantilla de Feature Request

```markdown
## 💡 Descripción de la Funcionalidad

Descripción clara de la funcionalidad que te gustaría ver implementada.

## 🎯 Problema que Resuelve

Descripción del problema que esta funcionalidad resolvería.

## 💭 Solución Propuesta

Descripción de cómo te gustaría que funcionara.

## 🔄 Alternativas Consideradas

Descripción de cualquier alternativa que hayas considerado.

## 📋 Información Adicional

Cualquier otra información o screenshots sobre la solicitud de funcionalidad.
```

## 🧪 Testing

### Ejecutar Tests

```bash
# Tests unitarios
php artisan test

# Tests específicos
php artisan test --filter BookTest

# Tests con coverage
php artisan test --coverage
```

### Escribir Tests

```php
<?php

namespace Tests\Feature;

use App\Models\Book;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

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

## 📚 Documentación

### Actualizar Documentación

Si añades nuevas funcionalidades, actualiza:

1. **README.md** - Documentación principal
2. **DOCUMENTACION_TECNICA.md** - Documentación técnica
3. **CHANGELOG.md** - Registro de cambios
4. **Comentarios en código** - Documentación inline

### Estándares de Documentación

- Usa lenguaje claro y conciso
- Incluye ejemplos de código cuando sea necesario
- Mantén la documentación actualizada
- Usa emojis para mejorar la legibilidad

## 🤝 Código de Conducta

### Nuestros Estándares

- Usar lenguaje acogedor e inclusivo
- Respetar diferentes puntos de vista y experiencias
- Aceptar graciosamente la crítica constructiva
- Enfocarse en lo que es mejor para la comunidad
- Mostrar empatía hacia otros miembros de la comunidad

### Nuestras Responsabilidades

- Mantener un ambiente acogedor e inclusivo
- Clarificar los estándares de comportamiento aceptable
- Tomar acción correctiva apropiada y justa
- Remover, editar o rechazar comentarios, commits, código, etc.

## ❓ Preguntas Frecuentes

### ¿Cómo empiezo a contribuir?

1. Lee esta guía completa
2. Configura tu entorno de desarrollo
3. Encuentra un issue etiquetado como "good first issue"
4. Crea una rama y empieza a trabajar

### ¿Qué hago si tengo una pregunta?

- Revisa la documentación existente
- Busca en issues cerrados
- Abre un nuevo issue con la etiqueta "question"

### ¿Cómo sé si mi contribución será aceptada?

- Sigue los estándares de código
- Incluye tests apropiados
- Documenta tus cambios
- Mantén los commits pequeños y enfocados

### ¿Puedo contribuir sin experiencia en Laravel?

¡Absolutamente! Hay muchas formas de contribuir:
- Mejorar documentación
- Reportar bugs
- Sugerir funcionalidades
- Ayudar con testing

---

## 🙏 Agradecimientos

Gracias a todos los contribuidores que han ayudado a hacer Retrolector mejor. Tu tiempo y esfuerzo son muy apreciados.

---

**¿Tienes alguna pregunta?** No dudes en abrir un issue o contactarnos directamente. 