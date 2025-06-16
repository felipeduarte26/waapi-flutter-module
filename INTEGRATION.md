# Guia de Integração - Waapi Module

Este guia mostra como integrar o módulo `@felipeduarte26/waapi-module` em um projeto React Native.

## 📦 Instalação

```bash
# Instalar o pacote
npm install @felipeduarte26/waapi-module --registry=https://npm.pkg.github.com

# Configuração automática (recomendada)
npx react-native waapi-setup
```

## ⚙️ Configuração Manual

### Android

**android/app/build.gradle:**

```gradle
repositories {
    maven {
        url '../node_modules/@felipeduarte26/waapi-module/android/repo'
    }
}

dependencies {
    debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'
    profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'
    releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'
}
```

### iOS

**ios/Podfile:**

```ruby
$waapi_module_path = '../node_modules/@felipeduarte26/waapi-module'

target 'YourApp' do
  pod 'WaapiModule', :path => "#{$waapi_module_path}"
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'WaapiModule'
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end
```

## 🔄 Pós-instalação

```bash
# Android
cd android && ./gradlew clean && cd ..

# iOS
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..

# React Native
npx react-native start --reset-cache
```

## 📱 Uso no Código

```javascript
import { NativeModules } from "react-native";
const { WaapiModule } = NativeModules;

// Usar o módulo
const result = await WaapiModule.someFunction();
```

## 🔍 Diagnóstico

```bash
# Verificar instalação
npx react-native waapi-info

# Verificar estrutura
ls node_modules/@felipeduarte26/waapi-module/
```

## 🚨 Troubleshooting

### Erro Android: "Could not resolve com.wiipo.waapi_module"

- Verificar se o repositório Maven foi adicionado ao build.gradle
- Executar `./gradlew clean`

### Erro iOS: "Pod not found"

- Verificar se o path no Podfile está correto
- Executar `pod deintegrate && pod install`

### Pacote não encontrado

- Verificar se tem acesso ao GitHub Packages
- Configurar `.npmrc` se necessário:

```
@felipeduarte26:registry=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=TOKEN
```

## Estrutura do Package

```
@felipeduarte26/waapi-module/
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
npm update @felipeduarte26/waapi-module --registry=https://npm.pkg.github.com
```

Após atualizar, sempre execute:

```bash
cd ios && pod install  # Para iOS
./gradlew clean        # Para Android (opcional)
```
