#!/bin/bash
# backup-restore.sh
# Backup & restore VPS data

BACKUP_DIR="backup_data"

if [ "$1" == "backup" ]; then
    echo "[*] Backing up VPS data..."
    mkdir -p $BACKUP_DIR
    sudo tar -czf $BACKUP_DIR/vps_backup_latest.tar.gz /root /etc || true
    echo "[*] Backup complete."

elif [ "$1" == "restore" ]; then
    echo "[*] Restoring latest backup..."
    if [ -f "$BACKUP_DIR/vps_backup_latest.tar.gz" ]; then
        sudo tar -xzf "$BACKUP_DIR/vps_backup_latest.tar.gz" -C /
        echo "[*] Restore complete."
    else
        echo "[!] No backup found, skipping restore."
    fi
else
    echo "Usage: $0 {backup|restore}"
fi
