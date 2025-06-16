#!/bin/bash

set -e

# Caminho base
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "BASE_DIR definido como: $BASE_DIR"

# Função para limpeza inicial
clean_waapi_module() {
  echo "🧹 Limpando modulo com segurança..."
  cd "$BASE_DIR"

  echo "🧹 Verificando e removendo frameworks iOS antigos..."
  FRAMEWORKS_FOUND=false

  if find . -name "*.framework" -o -name "*.xcframework" 2>/dev/null | grep -q .; then
    FRAMEWORKS_FOUND=true
  fi

  if [ "$FRAMEWORKS_FOUND" = true ]; then
    echo "📦 Encontrados frameworks antigos, removendo..."
    find . -name "*.framework" -type d -exec rm -rf {} + 2>/dev/null || true
    find . -name "*.xcframework" -type d -exec rm -rf {} + 2>/dev/null || true
    echo "✅ Frameworks antigos removidos"
  else
    echo "✅ Nenhum framework antigo encontrado"
  fi
}

# Função para limpar e fazer pub get nos packages (sem examples)
clean_packages() {
  echo "🧹 Limpando e rodando pub get nos packages..."
  cd "$BASE_DIR/packages"

  for project in */ ; do
    if [ -d "$project" ]; then
      echo "📦 Processando $project..."
      cd "$project"
      flutter clean
      flutter pub get
      cd ..
    fi
  done
}

# Função para flutter clean geral
flutter_clean_general() {
  echo "🧹 Executando flutter clean e pub get geral no waapi_module..."
  cd "$BASE_DIR"
  flutter clean
  flutter pub get
}

# Função para atualizar o Podfile para iOS
update_ios_podfile() {
  echo "🔄 Atualizando o Podfile para o projeto iOS..."
  cp "$BASE_DIR/templates/ios/podfile.txt" "$BASE_DIR/.ios/Podfile"
}

# Função para configurar Swift version
configure_swift_version() {
  echo "🔧 Configurando SWIFT_VERSION de forma otimizada..."

  IOS_DIR="$BASE_DIR/.ios"
  PROJECT_FILE="$IOS_DIR/Runner.xcodeproj/project.pbxproj"

  if [ -f "$PROJECT_FILE" ]; then
    cp "$PROJECT_FILE" "$PROJECT_FILE.backup"
    echo "  - Configurando SWIFT_VERSION = 5.0 no projeto Runner..."
    sed -i '' '/SWIFT_VERSION = /d' "$PROJECT_FILE"
    sed -i '' '/buildSettings = {/a\
				SWIFT_VERSION = 5.0;
' "$PROJECT_FILE"

    if grep -q "SWIFT_VERSION = 5.0" "$PROJECT_FILE"; then
      echo "✅ SWIFT_VERSION = 5.0 configurado com sucesso"
    else
      echo "⚠️  Aplicando configuração alternativa..."
      perl -i -pe 's/(buildSettings = \{)/$1\n\t\t\t\tSWIFT_VERSION = 5.0;/g' "$PROJECT_FILE"
    fi

    echo "✅ Configuração de SWIFT_VERSION concluída"
  else
    echo "⚠️  Arquivo project.pbxproj não encontrado em $PROJECT_FILE"
  fi
}

# Função para otimizar CocoaPods
optimize_cocoapods() {
  echo "🔧 Otimizando configurações do CocoaPods..."

  IOS_DIR="$BASE_DIR/.ios"
  cd "$IOS_DIR"

  rm -rf Podfile.lock Pods/

  export COCOAPODS_ALLOW_INSECURE_SOURCES=true
  export COCOAPODS_DISABLE_STATS=true

  # Limpar cache apenas se necessário
  if [ -d "$HOME/.cocoapods/repos" ]; then
    echo "🧹 Limpando cache do CocoaPods..."
    pod cache clean --all > /dev/null 2>&1 || true
  fi

  echo "✅ CocoaPods otimizado!"
}

# Função para executar pod install
execute_pod_install() {
  echo "🔧 Executando pod install ..."

  # Primeira tentativa - mais rápida
  if pod install --verbose; then
    echo "✅ Pod install executado com sucesso!"
    return 0
  fi

  echo "⚠️  Primeira tentativa falhou. Aplicando configurações adicionais..."

  cp Podfile Podfile.backup
  cat >> Podfile << 'EOF'

# Configurações otimizadas para resolver problemas de Swift version
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'

      # Otimizações específicas para AWS pods
      if target.name.include?('AWS') || target.name.downcase.include?('aws')
        config.build_settings['SWIFT_VERSION'] = '5.0'
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        config.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
      end
    end
  end
end
EOF

  echo "🔄 Executando pod install com configurações corrigidas..."
  if pod install --repo-update; then
    echo "✅ Pod install executado com configurações adicionais!"
    return 0
  else
    echo "❌ Pod install falhou mesmo com configurações adicionais."
    return 1
  fi
}

# Função para mostrar frameworks gerados
show_generated_frameworks() {
  echo ""
  echo "📂 Localizando frameworks iOS gerados..."
  FRAMEWORK_PATHS=$(find . -name "*.framework" -o -name "*.xcframework" 2>/dev/null)

  if [ -n "$FRAMEWORK_PATHS" ]; then
    echo "🎯 Frameworks encontrados:"
    echo "$FRAMEWORK_PATHS" | while read -r framework_path; do
      if [ -n "$framework_path" ] && [ -d "$framework_path" ]; then
        ABS_PATH=$(cd "$(dirname "$framework_path")" && pwd)/$(basename "$framework_path")
        DIR_SIZE=$(du -sh "$framework_path" | awk '{print $1}')
        echo "   📱 $ABS_PATH ($DIR_SIZE)"
      fi
    done
  else
    echo "⚠️  Nenhum framework encontrado no diretório build"
  fi
}

# Função principal para build iOS
buildIos() {
  echo "🔄 Iniciando build para iOS..."
  cd "$BASE_DIR"

  echo "📦 Verificando cache do Flutter para iOS..."
  flutter precache --ios

  if [ ! -d ".ios" ]; then
    echo "⚠️ Diretório .ios não encontrado. Criando estrutura iOS..."
    flutter create -t module --ios-language swift .
  fi

  update_ios_podfile
  configure_swift_version
  optimize_cocoapods

  if ! execute_pod_install; then
    echo "❌ Falha crítica no pod install. Verifique a configuração do projeto."
    exit 1
  fi

  cd "$BASE_DIR"

  echo "🏗️ Gerando ios-framework..."

  BUILD_COMMAND="flutter build ios-framework --dart-define-from-file=config.json --no-tree-shake-icons --output=build/ios/framework"

  if $BUILD_COMMAND 2>&1 | tee /tmp/flutter_build_output.log; then
    echo "✅ BUILD iOS CONCLUÍDO COM SUCESSO!"
    show_generated_frameworks

    rm -f /tmp/flutter_build_output.log
  else
    BUILD_EXIT_CODE=$?
    echo "⚠️  Build retornou código $BUILD_EXIT_CODE. Verificando frameworks principais..."

    # Verifica se os frameworks principais foram gerados
    if [ -d "build/ios/framework/Release/App.xcframework" ] && [ -d "build/ios/framework/Release/Flutter.xcframework" ]; then
      # Verifica se o erro foi apenas relacionado ao simulador
      if grep -q "Unable to build plugin frameworks for simulator" /tmp/flutter_build_output.log 2>/dev/null; then
        echo "🎯 Frameworks principais gerados com sucesso!"
        echo "⚠️  Erro detectado apenas na compilação para simulador (x86_64)"
        echo "📱 O módulo está funcional para dispositivos físicos iOS"
        echo "✅ BUILD iOS CONCLUÍDO COM SUCESSO (ignorando erro de simulador)!"

        show_generated_frameworks
        rm -f /tmp/flutter_build_output.log
      else
        echo "❌ Build falhou com outros erros."
        echo "📋 Verifique os logs para mais detalhes."
        exit 1
      fi
    else
      echo "❌ Frameworks principais não foram gerados."
      exit 1
    fi
  fi
}

# ==============================================
# EXECUÇÃO PRINCIPAL
# ==============================================

echo "🚀 Iniciando processo de build iOS otimizado..."

# 1. Limpeza inicial do waapi_module
clean_waapi_module

# 2. Limpeza e pub get dos packages (sem examples)
clean_packages

# 3. Flutter clean geral
flutter_clean_general

# 4. Build iOS
buildIos

echo "✅ Script iOS finalizado com sucesso."
