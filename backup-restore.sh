#!/bin/bash
set -e

MODE=$1

if [[ "$MODE" == "backup" ]]; then
    echo "[INFO] Creating backup..."
    tar -czf backup.tar.gz /home/runner/work || true
    echo "[INFO] Backup created: backup.tar.gz"
fi

if [[ "$MODE" == "restore" ]]; then
    echo "[INFO] Restoring backup..."
    mkdir -p /home/runner/work
    tar -xzf backup.tar.gz -C / || true
    echo "[INFO] Backup restored!"
fi
