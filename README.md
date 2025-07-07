# 📚 Retrolector - Sistema de Biblioteca Digital

[![Laravel](https://img.shields.io/badge/Laravel-10.x-red.svg)](https://laravel.com)
[![PHP](https://img.shields.io/badge/PHP-8.2+-blue.svg)](https://php.net)
[![MySQL](https://img.shields.io/badge/MySQL-8.0+-orange.svg)](https://mysql.com)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3+-purple.svg)](https://getbootstrap.com)

## 🎯 Descripción

**Retrolector** es un sistema completo de gestión de biblioteca digital desarrollado en Laravel que permite a los usuarios explorar, comprar, prestar y gestionar libros digitales. El sistema incluye funcionalidades avanzadas para administradores y una experiencia de usuario moderna e intuitiva.

## ✨ Características Principales

### 🔐 Sistema de Autenticación Dual
- **Login de Clientes**: Acceso exclusivo para usuarios registrados
- **Login de Administradores**: Panel administrativo con permisos especiales
- Registro de usuarios con validación completa
- Gestión de sesiones y seguridad

### 📖 Gestión de Libros
- **Catálogo completo** con filtros avanzados
- **4 modalidades de precio**: Compra física, compra online, préstamo físico, préstamo online
- **Vista previa gratuita** de libros
- **Gestión de stock** en tiempo real
- **Sistema de ubicación** para libros físicos
- **Subida de portadas** e imágenes
- **Archivos PDF** para lectura digital

### 👥 Panel de Usuario
- Dashboard personalizado con estadísticas
- **Gestión de préstamos** y reservas
- **Sistema de favoritos**
- **Historial de compras** y préstamos
- **Notificaciones** en tiempo real
- **Mensajería interna**
- **Reseñas y calificaciones**
- **Análisis de lectura**

### 🛠️ Panel de Administración
- **Gestión completa de libros** (CRUD)
- **Administración de usuarios**
- **Control de préstamos** y reservas
- **Moderación de reseñas**
- **Gestión de categorías** y autores
- **Reportes y estadísticas**
- **Sistema de notificaciones**

### 🎨 Interfaz Moderna
- **Diseño responsive** con Bootstrap 5
- **Tema claro/oscuro**
- **Animaciones** y transiciones suaves
- **Iconografía** FontAwesome
- **UX/UI optimizada**

## 🚀 Tecnologías Utilizadas

### Backend
- **Laravel 10.x** - Framework PHP
- **PHP 8.2+** - Lenguaje de programación
- **MySQL 8.0+** - Base de datos
- **Eloquent ORM** - Mapeo objeto-relacional

### Frontend
- **Bootstrap 5.3** - Framework CSS
- **FontAwesome 6** - Iconos
- **JavaScript ES6+** - Interactividad
- **Animate.css** - Animaciones

### Herramientas
- **Composer** - Gestión de dependencias
- **Artisan** - CLI de Laravel
- **Git** - Control de versiones

## 📋 Requisitos del Sistema

- **PHP**: 8.2 o superior
- **Composer**: Última versión estable
- **MySQL**: 8.0 o superior
- **Node.js**: 16+ (para compilación de assets)
- **Servidor web**: Apache/Nginx
- **Extensiones PHP**: BCMath, Ctype, JSON, Mbstring, OpenSSL, PDO, Tokenizer, XML

## 🛠️ Instalación

### 1. Clonar el Repositorio
```bash
git clone https://github.com/alent123/PROYECTO.git
cd PROYECTO
```

### 2. Instalar Dependencias
```bash
cd retrolector
composer install
npm install
```

### 3. Configurar Variables de Entorno
```bash
cp .env.example .env
php artisan key:generate
```

Editar `.env` con la configuración de tu base de datos:
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=retrolector
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_contraseña
```

### 4. Ejecutar Migraciones
```bash
php artisan migrate
php artisan db:seed
```

### 5. Configurar Storage
```bash
php artisan storage:link
```

### 6. Compilar Assets (Opcional)
```bash
npm run dev
# o para producción
npm run build
```

### 7. Configurar Permisos
```bash
chmod -R 775 storage bootstrap/cache
```

## 🗄️ Base de Datos

### Estructura Principal
- **usuarios**: Gestión de usuarios y administradores
- **libros**: Catálogo completo de libros
- **autors**: Información de autores
- **categorias**: Categorías de libros
- **prestamos**: Sistema de préstamos
- **reservas**: Sistema de reservas
- **compras**: Historial de compras
- **resenas**: Sistema de reseñas
- **favoritos**: Libros favoritos de usuarios
- **notificaciones**: Sistema de notificaciones

### Características de la Base de Datos
- **Relaciones complejas** entre tablas
- **Índices optimizados** para búsquedas
- **Claves foráneas** para integridad referencial
- **Campos de auditoría** (created_at, updated_at)
- **Soft deletes** para eliminación segura

## 🎮 Uso del Sistema

### Para Usuarios
1. **Registro**: Crear cuenta en `/register`
2. **Login**: Acceder en `/login`
3. **Explorar**: Navegar por el catálogo en `/books/catalog`
4. **Comprar/Prestar**: Seleccionar modalidad de adquisición
5. **Gestionar**: Acceder al dashboard en `/user/dashboard`

### Para Administradores
1. **Login**: Acceder en `/admin-login`
2. **Dashboard**: Panel principal en `/admin/dashboard`
3. **Gestión de Libros**: `/admin/books`
4. **Gestión de Usuarios**: `/admin/users`
5. **Reportes**: `/admin/reports`

## 🔧 Configuración Avanzada

### Personalización de Temas
El sistema soporta temas personalizables:
- Modificar variables CSS en `resources/css/app.css`
- Configurar colores en `config/app.php`
- Personalizar layouts en `resources/views/layouts/`

### Configuración de Email
```env
MAIL_MAILER=smtp
MAIL_HOST=tu_servidor_smtp
MAIL_PORT=587
MAIL_USERNAME=tu_email
MAIL_PASSWORD=tu_contraseña
MAIL_ENCRYPTION=tls
```

### Configuración de Archivos
```env
FILESYSTEM_DISK=public
```

## 📊 Características Técnicas

### Seguridad
- **Autenticación** con middleware personalizado
- **Validación** de formularios robusta
- **CSRF protection** habilitada
- **Sanitización** de datos de entrada
- **Control de acceso** basado en roles

### Rendimiento
- **Caché** de consultas frecuentes
- **Paginación** optimizada
- **Lazy loading** de relaciones
- **Compresión** de assets
- **Optimización** de consultas SQL

### Escalabilidad
- **Arquitectura MVC** modular
- **Separación** de responsabilidades
- **Código reutilizable** y mantenible
- **Documentación** completa
- **Tests** unitarios (preparado)

## 🐛 Solución de Problemas

### Errores Comunes

**Error de permisos:**
```bash
chmod -R 775 storage bootstrap/cache
```

**Error de migración:**
```bash
php artisan migrate:fresh --seed
```

**Error de storage:**
```bash
php artisan storage:link
```

**Error de dependencias:**
```bash
composer install --no-dev
```

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autor

**Alejandro López**
- GitHub: [@alent123](https://github.com/alent123)
- Email: contacto@retrolector.com

## 🙏 Agradecimientos

- **Laravel Team** por el framework
- **Bootstrap Team** por el framework CSS
- **FontAwesome** por los iconos
- **Comunidad open source** por las librerías utilizadas

## 📞 Soporte

Si tienes alguna pregunta o necesitas ayuda:
- 📧 Email: soporte@retrolector.com
- 🐛 Issues: [GitHub Issues](https://github.com/alent123/PROYECTO/issues)
- 📖 Wiki: [Documentación completa](https://github.com/alent123/PROYECTO/wiki)

---

⭐ **¡No olvides dar una estrella al proyecto si te ha sido útil!** 