# 🐳 Docker - Retrolector

Esta guía te ayudará a configurar y ejecutar el proyecto Retrolector usando Docker.

## 📋 Prerrequisitos

- **Docker**: 20.10 o superior
- **Docker Compose**: 2.0 o superior
- **Git**: Última versión estable

## 🚀 Inicio Rápido

### 1. Clonar el Repositorio
```bash
git clone https://github.com/alent123/PROYECTO.git
cd PROYECTO
```

### 2. Configurar Variables de Entorno
```bash
# Copiar archivo de ejemplo
cp retrolector/.env.example retrolector/.env

# Editar variables para Docker
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=db/g' retrolector/.env
sed -i 's/DB_DATABASE=retrolector/DB_DATABASE=retrolector/g' retrolector/.env
sed -i 's/DB_USERNAME=root/DB_USERNAME=retrolector_user/g' retrolector/.env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=retrolector_password/g' retrolector/.env
sed -i 's/REDIS_HOST=127.0.0.1/REDIS_HOST=redis/g' retrolector/.env
```

### 3. Construir y Ejecutar
```bash
# Construir imágenes
docker-compose build

# Ejecutar servicios
docker-compose up -d

# Instalar dependencias
docker-compose exec app composer install
docker-compose exec app npm install
docker-compose exec app npm run build

# Generar clave de aplicación
docker-compose exec app php artisan key:generate

# Ejecutar migraciones
docker-compose exec app php artisan migrate
docker-compose exec app php artisan db:seed

# Configurar permisos
docker-compose exec app chmod -R 775 storage bootstrap/cache
docker-compose exec app chown -R laravel:www-data storage bootstrap/cache
```

### 4. Acceder a la Aplicación
- **Aplicación**: http://localhost
- **PHPMyAdmin**: http://localhost:8080
- **MailHog**: http://localhost:8025

## 🛠️ Comandos Útiles

### Gestión de Contenedores
```bash
# Ver logs
docker-compose logs -f app

# Ejecutar comandos Artisan
docker-compose exec app php artisan migrate
docker-compose exec app php artisan make:controller TestController

# Acceder al contenedor
docker-compose exec app bash

# Reiniciar servicios
docker-compose restart

# Detener servicios
docker-compose down

# Detener y eliminar volúmenes
docker-compose down -v
```

### Desarrollo
```bash
# Ver logs en tiempo real
docker-compose logs -f

# Ejecutar tests
docker-compose exec app php artisan test

# Limpiar caché
docker-compose exec app php artisan cache:clear
docker-compose exec app php artisan config:clear
docker-compose exec app php artisan route:clear
docker-compose exec app php artisan view:clear

# Compilar assets en desarrollo
docker-compose exec app npm run dev

# Compilar assets para producción
docker-compose exec app npm run build
```

## 🗄️ Base de Datos

### Acceso Directo
```bash
# Conectar a MySQL
docker-compose exec db mysql -u root -p retrolector

# Usuario: root
# Contraseña: retrolector_root_password
```

### Backup y Restore
```bash
# Crear backup
docker-compose exec db mysqldump -u root -p retrolector > backup.sql

# Restaurar backup
docker-compose exec -T db mysql -u root -p retrolector < backup.sql
```

### Reset de Base de Datos
```bash
# Eliminar y recrear
docker-compose exec app php artisan migrate:fresh --seed
```

## 📧 Email Testing

### MailHog
MailHog está configurado para capturar todos los emails enviados por la aplicación:

1. Accede a http://localhost:8025
2. Todos los emails aparecerán en la interfaz web
3. Configuración en `.env`:
```env
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
```

## 🔍 Monitoreo

### Logs
```bash
# Logs de la aplicación
docker-compose logs app

# Logs de Nginx
docker-compose logs nginx

# Logs de MySQL
docker-compose logs db

# Logs de Redis
docker-compose logs redis
```

### Estado de Servicios
```bash
# Ver estado de contenedores
docker-compose ps

# Ver uso de recursos
docker stats
```

## 🚀 Producción

### Configuración de Producción
```bash
# Construir para producción
docker-compose -f docker-compose.prod.yml build

# Ejecutar en producción
docker-compose -f docker-compose.prod.yml up -d
```

### Variables de Entorno de Producción
```env
APP_ENV=production
APP_DEBUG=false
APP_URL=https://tu-dominio.com

DB_HOST=db
DB_DATABASE=retrolector
DB_USERNAME=retrolector_user
DB_PASSWORD=contraseña_segura

REDIS_HOST=redis
REDIS_PASSWORD=contraseña_redis

MAIL_MAILER=smtp
MAIL_HOST=tu-servidor-smtp.com
MAIL_PORT=587
MAIL_USERNAME=tu-email@dominio.com
MAIL_PASSWORD=tu-contraseña
MAIL_ENCRYPTION=tls
```

## 🔧 Personalización

### Puerto Personalizado
Para cambiar el puerto de la aplicación, edita `docker-compose.yml`:
```yaml
nginx:
  ports:
    - "8080:80"  # Cambia 8080 por el puerto deseado
```

### Volúmenes Personalizados
Para persistir datos en ubicaciones específicas:
```yaml
volumes:
  - ./data/mysql:/var/lib/mysql
  - ./data/redis:/data
  - ./uploads:/var/www/storage/app/public/uploads
```

### Configuración de PHP
Edita `docker/php/php.ini` para personalizar la configuración de PHP:
```ini
memory_limit = 1G
max_execution_time = 600
upload_max_filesize = 200M
```

## 🐛 Solución de Problemas

### Problemas Comunes

**Error de permisos:**
```bash
docker-compose exec app chown -R laravel:www-data storage bootstrap/cache
```

**Error de conexión a base de datos:**
```bash
# Verificar que MySQL esté ejecutándose
docker-compose ps db

# Reiniciar servicios
docker-compose restart db app
```

**Error de memoria:**
```bash
# Aumentar memoria en docker-compose.yml
services:
  app:
    deploy:
      resources:
        limits:
          memory: 1G
```

**Error de puerto ocupado:**
```bash
# Verificar puertos en uso
netstat -tulpn | grep :80

# Cambiar puerto en docker-compose.yml
ports:
  - "8080:80"
```

### Limpieza
```bash
# Limpiar contenedores no utilizados
docker system prune

# Limpiar imágenes no utilizadas
docker image prune

# Limpiar volúmenes no utilizados
docker volume prune
```

## 📚 Recursos Adicionales

- [Documentación de Docker](https://docs.docker.com/)
- [Documentación de Docker Compose](https://docs.docker.com/compose/)
- [Laravel Docker](https://laravel.com/docs/10.x/sail)
- [MySQL Docker](https://hub.docker.com/_/mysql)
- [Redis Docker](https://hub.docker.com/_/redis)

---

## 🤝 Contribución

Si encuentras problemas con Docker o quieres mejorar la configuración:

1. Revisa los issues existentes
2. Crea un nuevo issue con detalles del problema
3. Proporciona logs y configuración relevante

---

**¡Disfruta desarrollando con Retrolector en Docker! 🚀** 