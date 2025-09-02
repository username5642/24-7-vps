#!/bin/bash
set -e

MODE=$1
BACKUP_FILE="backup.tar.gz"
WORK_DIR="/home/runner/work"

if [[ "$MODE" == "backup" ]]; then
    echo "[INFO] Creating backup..."
    mkdir -p "$WORK_DIR"
    tar -czf "$BACKUP_FILE" -C "$WORK_DIR" . || true
    echo "[INFO] Backup created: $BACKUP_FILE"
fi

if [[ "$MODE" == "restore" ]]; then
    if [[ -f "$BACKUP_FILE" ]]; then
        echo "[INFO] Restoring backup..."
        mkdir -p "$WORK_DIR"
        tar -xzf "$BACKUP_FILE" -C "$WORK_DIR" || true
        echo "[INFO] Backup restored!"
    else
        echo "[ERROR] Backup file $BACKUP_FILE not found!"
        exit 1
    fi
fi
