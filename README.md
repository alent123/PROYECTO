# 📚 Retrolector - Sistema de Biblioteca Digital

**Retrolector** es un sistema avanzado de gestión de biblioteca digital desarrollado en Laravel. Permite a usuarios explorar, comprar, prestar y gestionar libros físicos y digitales, y a los administradores controlar todo el catálogo y la experiencia de la biblioteca.
PROFESOR LA CARPETA DOND ESTA GUARDADO EL PROYECTO ESTA EN EL DRIVE, EL LINK DEL DRIVE ESTA EN EL WORD HASTA ABAJO DONDE DICE DRIVE JUNTO AL VIDEO 


---

## 🚀 Características Destacadas

### 🔐 Autenticación y Roles
- Login y registro diferenciados para usuarios y administradores
- Seguridad robusta y gestión de sesiones

### 📖 Gestión de Libros
- Catálogo con filtros avanzados: por estado, disponibilidad, tipo, fechas, badges visuales (Nuevo, Sin stock, Solo online, Solo físico, Con PDF)
- Modalidades: Compra física, compra online, préstamo físico, préstamo online
- Vista previa gratuita configurable
- Subida de portadas y PDF
- Gestión de stock y ubicación
- Edición y creación con previsualización en tiempo real

### 👤 Panel de Usuario
- Dashboard con estadísticas y recomendaciones
- Sección “Tus libros” con tabs: Compra Física, Compra Online, Préstamo Físico, Préstamo Online
- Acciones contextuales: leer, descargar, mensajes de estado
- Favoritos, historial, reservas, notificaciones y mensajería interna
- Análisis de lectura y reseñas

### 🛠️ Panel de Administración
- Gestión integral de libros, usuarios, autores y categorías
- Panel de estadísticas rápidas: libros creados, préstamos, ventas, sugerencias
- Filtros avanzados y contadores visuales en el catálogo
- Acciones rápidas: editar, eliminar, vista previa, ver como usuario
- Moderación de reseñas y reportes
- Alertas automáticas (stock bajo, préstamos vencidos, reseñas pendientes)

### 🎨 Interfaz Moderna
- Sidebar y colores tipo biblioteca
- Diseño responsive y accesible
- Animaciones, badges y toasts para feedback visual
- UX/UI profesional y amigable

---

## 🛠️ Tecnologías
- **Laravel 10.x** (PHP 8.2+)
- **MySQL 8.0+**
- **Bootstrap 5.3**, **FontAwesome 6**, **Animate.css**
- **JavaScript ES6+**
- **Composer**, **Artisan**, **Git**

---

## 📋 Instalación Rápida

```bash
git clone https://github.com/alent123/PROYECTO.git
cd PROYECTO/retrolector
composer install
npm install
cp .env.example .env
php artisan key:generate
# Edita .env con tus datos de base
php artisan migrate --seed
php artisan storage:link
npm run dev # o npm run build para producción
```

---

## 🗄️ Base de Datos
- Tablas: usuarios, libros, autors, categorias, prestamos, reservas, compras, resenas, favoritos, notificaciones
- Relaciones y claves foráneas bien definidas
- Triggers y procedimientos para stock y vencimientos
- Seeders y datos de ejemplo incluidos

---

## 🎮 Uso del Sistema

### Usuarios
- Registro y login en `/register` y `/login`
- Explora el catálogo, compra o solicita préstamos
- Gestiona tus libros en tabs claros y visuales
- Recibe notificaciones y mensajes

### Administradores
- Login en `/admin-login`
- Dashboard con estadísticas y alertas
- Gestión avanzada de libros, usuarios, autores y categorías
- Filtros y acciones rápidas en el catálogo
- Moderación y reportes

---

## 🔧 Personalización y Configuración
- Temas y colores editables en `resources/css/app.css` y `config/app.php`
- Configuración de email y archivos en `.env`
- Layouts personalizables en `resources/views/layouts/`

---

## 🏆 Experiencia y Lógica
- Todas las reglas de negocio están alineadas entre backend y frontend
- Lógica de disponibilidad, stock, badges y acciones consistente
- Experiencia moderna, profesional y lista para producción

---

## 📈 Mejoras Futuras Sugeridas
- Acciones masivas y exportación de reportes
- Panel de analíticas avanzado
- Notificaciones push/email
- Auditoría y logs
- Pruebas automatizadas

---

**Retrolector** es la solución ideal para bibliotecas modernas, con una base sólida, lógica coherente y una experiencia de usuario/admin de primer nivel. 
