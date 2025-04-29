#!/bin/bash

# === Конфигурация ===
REPO_DIR="/var/repo/k3d_mobfs.git"        # Где живёт bare-репозиторий
WORK_TREE="/var/repo/k3d_mobfs"                 # Рабочая папка для реальных файлов
LOG_FILE="/var/log/git-post-receive.log"   # Куда писать логи деплоя
BRANCH="refs/heads/master"                 # Какая ветка должна деплоиться

# === Основная логика ===

# Читаем из стандартного ввода
while read oldrev newrev ref
do
  echo "$(date '+%Y-%m-%d %H:%M:%S') Received push: $ref" >> "$LOG_FILE"

  if [ "$ref" = "$BRANCH" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Deploying branch master..." >> "$LOG_FILE"

    GIT_WORK_TREE="$WORK_TREE" GIT_DIR="$REPO_DIR" git checkout -f master >> "$LOG_FILE" 2>&1

    if [ $? -eq 0 ]; then
      echo "$(date '+%Y-%m-%d %H:%M:%S') Deploy success ✅" >> "$LOG_FILE"
    else
      echo "$(date '+%Y-%m-%d %H:%M:%S') Deploy failed ❌" >> "$LOG_FILE"
      exit 1
    fi
  else
    echo "$(date '+%Y-%m-%d %H:%M:%S') Skipped branch $ref (only master is deployed)" >> "$LOG_FILE"
  fi
done

exit 0
