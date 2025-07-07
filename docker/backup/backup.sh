#!/bin/bash

# Script de backup automático para Retrolector
# Este script realiza backup de la base de datos y archivos importantes

# Configuración
DB_HOST="db"
DB_USER="root"
DB_PASS="${MYSQL_ROOT_PASSWORD}"
DB_NAME="retrolector"
BACKUP_DIR="/backups"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=30

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para logging
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

warning() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

# Crear directorio de backup si no existe
mkdir -p "$BACKUP_DIR"

log "Iniciando backup de Retrolector..."

# Backup de base de datos
log "Realizando backup de base de datos..."
DB_BACKUP_FILE="$BACKUP_DIR/retrolector_db_$DATE.sql.gz"

if mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" \
    --single-transaction \
    --routines \
    --triggers \
    --events \
    --add-drop-database \
    --databases "$DB_NAME" | gzip > "$DB_BACKUP_FILE"; then
    log "Backup de base de datos completado: $(basename $DB_BACKUP_FILE)"
else
    error "Error al realizar backup de base de datos"
    exit 1
fi

# Backup de archivos importantes
log "Realizando backup de archivos..."
FILES_BACKUP_FILE="$BACKUP_DIR/retrolector_files_$DATE.tar.gz"

# Crear backup de archivos importantes
if tar -czf "$FILES_BACKUP_FILE" \
    -C /var/www \
    storage/app/public \
    storage/logs \
    .env \
    2>/dev/null; then
    log "Backup de archivos completado: $(basename $FILES_BACKUP_FILE)"
else
    warning "No se pudieron respaldar algunos archivos"
fi

# Backup de configuración
log "Realizando backup de configuración..."
CONFIG_BACKUP_FILE="$BACKUP_DIR/retrolector_config_$DATE.tar.gz"

if tar -czf "$CONFIG_BACKUP_FILE" \
    -C /var/www \
    config \
    routes \
    database/migrations \
    database/seeders \
    2>/dev/null; then
    log "Backup de configuración completado: $(basename $CONFIG_BACKUP_FILE)"
else
    warning "No se pudieron respaldar algunos archivos de configuración"
fi

# Verificar integridad de backups
log "Verificando integridad de backups..."

# Verificar backup de base de datos
if gunzip -t "$DB_BACKUP_FILE"; then
    log "✓ Backup de base de datos verificado"
else
    error "✗ Backup de base de datos corrupto"
    exit 1
fi

# Verificar backup de archivos
if tar -tzf "$FILES_BACKUP_FILE" >/dev/null 2>&1; then
    log "✓ Backup de archivos verificado"
else
    warning "✗ Backup de archivos podría estar corrupto"
fi

# Verificar backup de configuración
if tar -tzf "$CONFIG_BACKUP_FILE" >/dev/null 2>&1; then
    log "✓ Backup de configuración verificado"
else
    warning "✗ Backup de configuración podría estar corrupto"
fi

# Limpiar backups antiguos
log "Limpiando backups antiguos (más de $RETENTION_DAYS días)..."
find "$BACKUP_DIR" -name "retrolector_*" -type f -mtime +$RETENTION_DAYS -delete

# Mostrar estadísticas
BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
BACKUP_COUNT=$(find "$BACKUP_DIR" -name "retrolector_*" -type f | wc -l)

log "Backup completado exitosamente!"
log "Tamaño total de backups: $BACKUP_SIZE"
log "Número de archivos de backup: $BACKUP_COUNT"
log "Ubicación: $BACKUP_DIR"

# Crear archivo de metadatos
METADATA_FILE="$BACKUP_DIR/backup_metadata_$DATE.json"
cat > "$METADATA_FILE" << EOF
{
    "backup_date": "$(date -Iseconds)",
    "database_file": "$(basename $DB_BACKUP_FILE)",
    "files_file": "$(basename $FILES_BACKUP_FILE)",
    "config_file": "$(basename $CONFIG_BACKUP_FILE)",
    "database_size": "$(du -h $DB_BACKUP_FILE | cut -f1)",
    "files_size": "$(du -h $FILES_BACKUP_FILE | cut -f1)",
    "config_size": "$(du -h $CONFIG_BACKUP_FILE | cut -f1)",
    "retention_days": $RETENTION_DAYS,
    "version": "1.0.0"
}
EOF

log "Metadatos guardados en: $(basename $METADATA_FILE)"

# Notificar éxito
log "🎉 Proceso de backup completado exitosamente!" 