#!/bin/bash
# backup-restore.sh - Create or restore VPS backup

set -e

MODE=$1
BACKUP_FILE="/tmp/vps-backup/full-vps-backup.tar.gz"
WORK_DIR="/"

if [[ "$MODE" == "backup" ]]; then
    echo "[INFO] Creating full VPS backup..."
    mkdir -p /tmp/vps-backup
    sudo tar --exclude=/tmp/* \
             --exclude=/proc/* \
             --exclude=/sys/* \
             --exclude=/dev/* \
             --exclude=/run/* \
             --exclude=/mnt/* \
             --exclude=/var/lib/docker/* \
             --exclude=/home/runner/work/* \
             -czf "$BACKUP_FILE" "$WORK_DIR"
    echo "[INFO] Backup created at $BACKUP_FILE"

elif [[ "$MODE" == "restore" ]]; then
    if [[ -f "$BACKUP_FILE" ]]; then
        echo "[INFO] Restoring backup..."
        sudo tar -xzf "$BACKUP_FILE" -C "$WORK_DIR"
        echo "[INFO] Backup restored!"
    else
        echo "[ERROR] Backup file $BACKUP_FILE not found!"
        exit 1
    fi
else
    echo "[ERROR] Usage: $0 {backup|restore}"
    exit 1
fi
