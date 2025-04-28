#!/bin/bash

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}▶️ Начинаем создание структуры проекта MobFS...${NC}"

# Функция безопасного создания папки
create_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
    echo -e "${GREEN}✅ Создан каталог: $1${NC}"
  else
    echo -e "${RED}⚠️ Каталог уже существует: $1${NC}"
  fi
}

# Функция безопасного создания файла
create_file() {
  if [ ! -f "$1" ]; then
    touch "$1"
    echo -e "${GREEN}✅ Создан файл: $1${NC}"
  else
    echo -e "${RED}⚠️ Файл уже существует: $1${NC}"
  fi
}

# Создание папок
create_dir "manifests/base"
create_dir "manifests/volumes"
create_dir "manifests/configmaps"
create_dir "scripts"
create_dir "docs"
create_dir "charts/mobfs/templates"

# Создание файлов
create_file "README.md"
create_file ".gitignore"
create_file "test_connection.txt"

# Манифесты
create_file "manifests/base/namespace.yaml"
create_file "manifests/base/deployment.yaml"
create_file "manifests/base/service.yaml"
create_file "manifests/base/ingress.yaml"

# Volumes
create_file "manifests/volumes/pv.yaml"
create_file "manifests/volumes/pvc.yaml"

# Configmaps
create_file "manifests/configmaps/app-config.yaml"
create_file "manifests/configmaps/secrets.yaml"

# Скрипты
create_file "scripts/deploy.sh"
create_file "scripts/build.sh"
create_file "scripts/cleanup.sh"

# Документация
create_file "docs/architecture.md"
create_file "docs/README.md"

# Helm Chart
create_file "charts/mobfs/Chart.yaml"
create_file "charts/mobfs/values.yaml"

echo -e "${GREEN}🎉 Структура проекта MobFS успешно создана!${NC}"
exit 0
