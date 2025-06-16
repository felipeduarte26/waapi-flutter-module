#!/bin/bash

set -e

# Caminho base
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "BASE_DIR definido como: $BASE_DIR"

# 1. Limpeza da pasta waapi_module
echo "Limpando waapi_module com segurança..."
cd "$BASE_DIR/waapi_module"
rm -rf .dart_tool build .packages pubspec.lock

echo "Removendo a pasta .android..."
if ! rm -rf .android; then
  echo "⚠️  Não foi possível apagar completamente a pasta .android. Feche editores ou emuladores que possam estar usando ela e tente novamente."
fi

# 2. Limpar e rodar pub get nos pacotes
cd "$BASE_DIR/waapi_module/packages"
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
cd "$BASE_DIR/waapi_module"
echo "Executando flutter clean e pub get geral no waapi_module..."
flutter clean
flutter pub get

# Função para sobrescrever gradle.properties
setGradleProperties() {
  local gradle_file="$BASE_DIR/waapi_module/.android/gradle.properties"
  echo "Sobrescrevendo gradle.properties..."

  cat > "$gradle_file" <<EOF
org.gradle.jvmargs=-Xmx8G -XX:MaxMetaspaceSize=6G -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC
android.useAndroidX=true
android.enableJetifier=true
EOF

  echo "gradle.properties configurado!"
}

# Função para build Android
buildAndroid() {
  echo "🔄 Iniciando build para Android..."
  cd "$BASE_DIR/waapi_module"

  if [ ! -d ".android" ]; then
    echo "⚠️ A pasta .android não existe. Pulando geração do AAR."
    return
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

  echo "Gerando AAR em modules/waapi_module..."
  export GRADLE_OPTS="-Xmx10G -XX:MaxMetaspaceSize=8G"
  #flutter build aar --dart-define-from-file=config.json --no-tree-shake-icons -v
  flutter build aar --dart-define-from-file=config.json --no-tree-shake-icons -v > build_log.txt 2>&1

}

buildAndroid

echo "✅ Script finalizado com sucesso."
