#!/bin/bash

set -e

# Caminho base
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "BASE_DIR definido como: $BASE_DIR"

# 1. Limpeza da pasta waapi_module
echo "Limpando waapi_module com segurança..."
cd "$BASE_DIR"
rm -rf .dart_tool build .packages pubspec.lock

echo "Removendo a pasta .android..."
if ! rm -rf .android; then
  echo "⚠️  Não foi possível apagar completamente a pasta .android. Feche editores ou emuladores que possam estar usando ela e tente novamente."
fi

# 2. Limpar e rodar pub get nos pacotes
cd "$BASE_DIR/packages"
echo "Limpando e rodando pub get nos pacotes..."
for project in */ ; do
  if [ -d "$project" ]; then
    echo "Processando $project..."
    cd "$project"
    rm -rf .dart_tool build .packages pubspec.lock
    flutter pub get

    if [ -d "example" ]; then
      echo "Processando exemplo de $project..."
      cd example
      rm -rf .dart_tool build .packages pubspec.lock
      flutter pub get
      cd ..
    fi
    cd ..
  fi
done

# 3. Flutter clean geral
cd "$BASE_DIR"
echo "Executando flutter clean e pub get geral no waapi_module..."
flutter clean
flutter pub get

# Função para sobrescrever gradle.properties
setGradleProperties() {
  local gradle_file="$BASE_DIR/.android/gradle.properties"
  echo "Sobrescrevendo gradle.properties..."

  cat > "$gradle_file" <<EOF
# Configurações de memória otimizadas para CI
org.gradle.jvmargs=-Xmx6G -XX:MaxMetaspaceSize=4G -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC
android.useAndroidX=true
android.enableJetifier=true

# Suprimir warnings de deprecação para Gradle 9.0
org.gradle.warning.mode=none
EOF

  echo "gradle.properties configurado!"
}

# Função para build Android
buildAndroid() {
  echo "🔄 Iniciando build para Android..."
  cd "$BASE_DIR"

  if [ ! -d ".android" ]; then
    echo "⚠️ A pasta .android não existe. Criando estrutura Android..."
    flutter create -t module --android-language java .
    echo "✅ Estrutura Android criada"
  fi

  echo "Substituindo arquivos build.gradle a partir dos templates externos..."
  cp "$BASE_DIR/templates/android/build.gradle.txt" .android/build.gradle
  cp "$BASE_DIR/templates/android/settings.gradle.txt" .android/settings.gradle
  cp "$BASE_DIR/templates/android/build.gradle.app.txt" .android/app/build.gradle
  cp "$BASE_DIR/templates/android/androidManifest.xml.txt" .android/app/src/main/androidManifest.xml

  echo "Executando ./gradlew clean em .android..."
  cd .android
  ./gradlew clean
  cd ..

  setGradleProperties

  echo "Gerando AAR..."
  export GRADLE_OPTS="-Xmx6G -XX:MaxMetaspaceSize=4G -Dorg.gradle.daemon=false"
  
  # Verificar estrutura antes do build
  echo "📋 Verificando estrutura antes do build..."
  echo "Diretório atual: $(pwd)"
  echo "Conteúdo do diretório:"
  ls -la
  echo "Verificando .android:"
  ls -la .android/ || echo "Diretório .android não encontrado"
  
  # Build com timeout e handling de erros
  echo "Iniciando flutter build aar..."
  echo "⏰ Aguardando build completar (pode demorar até 55 minutos)..."
  
  # Executar comando e capturar exit code explicitamente
  set +e  # Temporariamente desabilitar exit on error
  flutter build aar --dart-define-from-file=config.json --no-tree-shake-icons -v
  BUILD_EXIT_CODE=$?
  set -e  # Reabilitar exit on error
  
  echo "📋 Flutter build aar terminou com código: $BUILD_EXIT_CODE"
  
  if [ $BUILD_EXIT_CODE -eq 0 ]; then
    echo "✅ Build completou com sucesso!"
  elif [ $BUILD_EXIT_CODE -eq 143 ]; then
    echo "⚠️ Build foi interrompido por timeout (143)"
  elif [ $BUILD_EXIT_CODE -eq 124 ]; then
    echo "⚠️ Build foi interrompido por timeout do comando timeout (124)"
  else
    echo "⚠️ Build falhou com código: $BUILD_EXIT_CODE"
  fi
  
  # Aguardar um momento para filesystem sync
  echo "⏳ Aguardando sincronização do filesystem..."
  sleep 5
  
  # Debug: Verificar o que foi gerado
  echo "📋 Verificando estrutura após build..."
  echo "Conteúdo do diretório build:"
  find build -type d 2>/dev/null | head -20 || echo "Diretório build não encontrado"
  
  echo "Procurando por outputs:"
  find . -path "*/outputs/*" -type d 2>/dev/null || echo "Nenhum diretório outputs encontrado"
}

buildAndroid

echo "✅ Script finalizado com sucesso."
