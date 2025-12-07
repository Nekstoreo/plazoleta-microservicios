#!/bin/bash

# Script de inicialización para clonar y configurar submódulos con tags específicos
# Uso: ./init-submodules.sh [tag]
# Ejemplo: ./init-submodules.sh v1.0.0

set -e

TAG=${1:-main}

echo "📦 Inicializando submódulos de Plazoleta..."
echo "🏷️  Usando rama/tag: $TAG"
echo ""

# Inicializar submódulos
echo "⬇️  Clonando submódulos..."
git submodule update --init --recursive

echo "✅ Submódulos clonados"
echo ""

# Actualizar a rama/tag específico (si no es main)
if [ "$TAG" != "main" ]; then
  echo "🔄 Actualizando submódulos a $TAG..."
  git submodule foreach git fetch --all --tags
  git submodule foreach git checkout "$TAG" 2>/dev/null || git submodule foreach git checkout -b "$TAG" "origin/$TAG"
  echo "✅ Submódulos actualizados a $TAG"
else
  echo "✅ Utilizando rama main (por defecto)"
fi

echo ""
echo "🎯 Configuración completada. Submódulos listos:"
git submodule foreach 'echo "  - $(basename $path): $(git describe --tags --always)"'
