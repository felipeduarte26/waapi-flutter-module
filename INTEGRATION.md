# Waapi Module - Integration Guide

Este guia explica como integrar o módulo Waapi Flutter em seu projeto React Native.

## Instalação

### 1. Instalar o package

```bash
npm install @wiipo/waapi-module --registry=https://npm.pkg.github.com
```

**Importante**: Você precisa estar autenticado no GitHub Packages NPM. Configure seu `.npmrc`:

```bash
# ~/.npmrc ou project/.npmrc
@wiipo:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=YOUR_GITHUB_TOKEN
```

### 2. Configuração Automática

O package executa automaticamente um script de setup pós-instalação que configura as dependências Android e iOS. Se algo der errado, você pode executar manualmente:

```bash
node node_modules/@wiipo/waapi-module/scripts/setup.js
```

## Configuração Android

### Automática (Recomendada)

O script de setup modificará automaticamente seu `android/app/build.gradle`:

```gradle
repositories {
    maven { url "$rootDir/../node_modules/@wiipo/waapi-module/android/repo" }
}

dependencies {
    debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'
    profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'
    releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'
}
```

### Manual

Se a configuração automática falhar, adicione manualmente ao `android/app/build.gradle`:

```gradle
android {
    // ... suas configurações existentes
}

repositories {
    // ... seus repositórios existentes
    maven { url "$rootDir/../node_modules/@wiipo/waapi-module/android/repo" }
}

dependencies {
    // ... suas dependências existentes
    debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'
    profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'
    releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'
}
```

## Configuração iOS

### Automática (Recomendada)

O script de setup modificará automaticamente seu `ios/Podfile`:

```ruby
pod 'WaapiModule', :path => '../node_modules/@wiipo/waapi-module'
```

Após a configuração, execute:

```bash
cd ios && pod install
```

### Manual

Se a configuração automática falhar, adicione manualmente ao `ios/Podfile`:

```ruby
target 'YourApp' do
  # ... seus pods existentes
  pod 'WaapiModule', :path => '../node_modules/@wiipo/waapi-module'
end
```

Então execute:

```bash
cd ios && pod install
```

## Verificação da Instalação

### Comando de Diagnóstico

```bash
npx react-native waapi-info
```

Este comando mostra:

- Status da instalação (Android/iOS)
- Caminhos dos arquivos
- Frameworks disponíveis
- Configurações aplicadas

### Exemplo de saída:

```
📦 Waapi Module Information:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏷️  Package: @wiipo/waapi-module@1.0.0

📱 Installation Status:
  Android: ✅ Installed
  iOS: ✅ Installed
  Complete: ✅ Ready

🤖 Android Configuration:
  Repository Path: /path/to/node_modules/@wiipo/waapi-module/android/repo
  Repository Exists: ✅
  Dependencies:
    debug: com.wiipo.waapi_module:flutter_debug:1.0
    profile: com.wiipo.waapi_module:flutter_profile:1.0
    release: com.wiipo.waapi_module:flutter_release:1.0

🍎 iOS Configuration:
  Framework Path: /path/to/node_modules/@wiipo/waapi-module/ios
  Frameworks Exist: ✅
  Podspec Name: WaapiModule
  Frameworks (15):
    Flutter.framework (framework)
    waapi_module.framework (framework)
    connectivity_plus.framework (framework)
    ...
```

## Uso no Código

```javascript
// No seu código React Native, você pode usar o módulo normalmente
// As configurações de bridge já estão incluídas no package

import { WaapiModule } from "@wiipo/waapi-module";

// O módulo estará disponível através das bridges nativas
// conforme implementado no Flutter
```

## Troubleshooting

### Android

**Erro: "Could not resolve com.wiipo.waapi_module:flutter_debug:1.0"**

1. Verifique se o repositório Maven está configurado corretamente
2. Execute `./gradlew clean` no diretório android
3. Verifique se os arquivos existem em `node_modules/@wiipo/waapi-module/android/repo`

**Erro de build gradle:**

```bash
cd android && ./gradlew clean
cd .. && npm run android
```

### iOS

**Erro: "No such module 'WaapiModule'"**

1. Execute `cd ios && pod install --repo-update`
2. Limpe o build: `cd ios && xcodebuild clean`
3. Verifique se o Podspec foi adicionado corretamente

**Erro de Swift version:**

O Podspec já configura a versão Swift 5.0. Se ainda houver problemas:

```bash
cd ios
pod deintegrate
pod install
```

### Geral

**Package não encontrado:**

1. Verifique sua autenticação no GitHub Packages
2. Confirme que o registry está configurado corretamente
3. Execute: `npm whoami --registry=https://npm.pkg.github.com`

**Builds falhando:**

1. Execute o diagnóstico: `npx react-native waapi-info`
2. Execute setup manual: `node node_modules/@wiipo/waapi-module/scripts/setup.js`
3. Limpe os caches:
   ```bash
   npm start -- --reset-cache
   cd android && ./gradlew clean
   cd ../ios && xcodebuild clean
   ```

## Estrutura do Package

```
@wiipo/waapi-module/
├── android/
│   └── repo/                    # Repositório Maven completo
│       ├── com/
│       │   └── wiipo/
│       │       └── waapi_module/
│       │           ├── flutter_debug/
│       │           ├── flutter_profile/
│       │           └── flutter_release/
│       └── [outras dependências Maven]
├── ios/
│   ├── Flutter.framework        # Framework Flutter base
│   ├── waapi_module.framework   # Módulo principal
│   └── [outros frameworks]      # Dependências dos plugins
├── scripts/
│   └── setup.js                 # Script de configuração
├── index.js                     # Entry point
├── react-native.config.js       # Configuração RN
├── WaapiModule.podspec          # Especificação CocoaPods
└── package.json
```

## Versionamento

O package segue semver:

- `1.0.x`: Patches e correções
- `1.x.0`: Funcionalidades novas compatíveis
- `x.0.0`: Breaking changes

Para atualizar:

```bash
npm update @wiipo/waapi-module --registry=https://npm.pkg.github.com
```

Após atualizar, sempre execute:

```bash
cd ios && pod install  # Para iOS
./gradlew clean        # Para Android (opcional)
```
