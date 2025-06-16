# 🚀 Configuração do Módulo Waapi Flutter

Este documento explica como configurar o projeto React Native para usar o módulo Waapi Flutter publicado no GitHub Packages.

## 📋 Pré-requisitos

- **Node.js** 18+
- **Yarn** 3.6.4 (obrigatório)
- **React Native** 0.75+
- **Token GitHub** com permissões de `read:packages`

## 🔐 1. Configuração do GitHub Packages

### 1.1. Criar/Atualizar `.yarnrc.yml`

Crie ou atualize o arquivo `.yarnrc.yml` na raiz do projeto:

```yaml
yarnPath: .yarn/releases/yarn-3.6.4.cjs

npmScopes:
  felipeduarte26:
    npmRegistryServer: https://npm.pkg.github.com
    npmAuthToken: SEU_GITHUB_TOKEN_AQUI

nodeLinker: node-modules
```

### 1.2. Obter Token GitHub

1. Acesse: **GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)**
2. Clique em **"Generate new token (classic)"**
3. Selecione as permissões:
   - ✅ `read:packages`
   - ✅ `repo` (se necessário)
4. Copie o token e substitua `SEU_GITHUB_TOKEN_AQUI` no arquivo `.yarnrc.yml`

## 📦 2. Instalação do Módulo

### 2.1. Instalar via Yarn

```bash
yarn add @felipeduarte26/waapi-module@1.0.6
```

### 2.2. Verificar Instalação

```bash
ls -la node_modules/@felipeduarte26/waapi-module/
```

Deve aparecer:

```
android/          # Artefatos Android (Maven repo)
ios/              # Frameworks iOS
package.json      # Metadados do pacote
WaapiModule.podspec # Especificação CocoaPods
```

## 🤖 3. Configuração Android

### 🎉 Configuração Automática

**O módulo Waapi já se configura automaticamente!** O script `postinstall` modificou o `android/app/build.gradle` automaticamente quando você executou `yarn add @felipeduarte26/waapi-module@1.0.6`.

**Verificar se funcionou:**

```bash
# Deve mostrar o repositório Maven
grep "felipeduarte26/waapi-module" android/app/build.gradle

# Deve mostrar as 3 dependências
grep "flutter_debug\|flutter_profile\|flutter_release" android/app/build.gradle
```

### 3.1. Configuração Manual (apenas se necessário)

Se a configuração automática falhou, adicione manualmente o repositório Maven na seção `repositories`:

```gradle
repositories {
    maven {
        url "$rootDir/../node_modules/@felipeduarte26/waapi-module/android/repo"
    }
    // ... outros repositórios
}
```

### 3.2. Configurar Dependências

Certifique-se de que estas dependências estão presentes:

```gradle
dependencies {
    // Flutter Waapi Module - todas as variantes
    debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'
    profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'
    releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'

    // ... outras dependências
}
```

## 🍎 4. Configuração iOS

### 4.1. Atualizar Podfile

No arquivo `ios/Podfile`, adicione:

```ruby
# Waapi Flutter Module
pod 'WaapiModule', :path => '../node_modules/@felipeduarte26/waapi-module'
```

### 4.2. Instalar Pods

```bash
cd ios
pod install
cd ..
```

## ✅ 5. Verificação da Instalação

### 5.1. Testar Build Android

```bash
yarn android
```

### 5.2. Verificar Logs

Procure por mensagens como:

```
> Configure project :app
✅ Sem erros relacionados ao waapi_module
✅ Build successful
```

### 5.3. Verificar Artefatos

```bash
# Verificar se os artefatos Maven foram encontrados
ls -la node_modules/@felipeduarte26/waapi-module/android/repo/com/wiipo/waapi_module/
```

Deve mostrar:

```
flutter_debug/    # Variante debug
flutter_profile/  # Variante profile
flutter_release/  # Variante release
```

## 🔧 6. Troubleshooting

### 6.1. Erro de Autenticação

```
➤ YN0035: │ @felipeduarte26/waapi-module@npm:1.0.6: The remote server failed to provide the requested resource
➤ YN0035: │   Response Code: 404 (Not Found)
```

**Solução:**

- Verificar se o token GitHub está correto
- Verificar se o token tem permissões `read:packages`
- Confirmar se está usando Yarn 3.6.4: `yarn --version`

### 6.2. Erro de Repositório Maven

```
Could not resolve com.wiipo.waapi_module:flutter_debug:1.0
```

**Solução:**

- Verificar se o caminho do repositório está correto:
  ```gradle
  url "$rootDir/../node_modules/@felipeduarte26/waapi-module/android/repo"
  ```
- Verificar se o módulo foi instalado: `ls node_modules/@felipeduarte26/`

### 6.3. Erro de Versão Incompatível

```
INSTALL_FAILED_VERSION_DOWNGRADE
```

**Solução:**

```bash
# Desinstalar app existente
adb uninstall com.wiipo

# Tentar novamente
yarn android
```

### 6.4. Problemas de Cache

```bash
# Limpar cache do Yarn
yarn cache clean

# Limpar cache do React Native
npx react-native clean

# Limpar build Android
cd android && ./gradlew clean && cd ..
```

## 📊 7. Estrutura do Módulo

```
@felipeduarte26/waapi-module@1.0.6
├── android/
│   └── repo/
│       └── com/wiipo/waapi_module/
│           ├── flutter_debug/1.0/     # ~52MB
│           ├── flutter_profile/1.0/   # ~44MB
│           └── flutter_release/1.0/   # ~35MB
├── ios/
│   └── *.framework/                   # Frameworks iOS
├── package.json
├── WaapiModule.podspec
└── README.md
```

## 🔄 8. Atualizações

### 8.1. Verificar Novas Versões

```bash
# Listar versões disponíveis
yarn info @felipeduarte26/waapi-module versions --json
```

### 8.2. Atualizar Versão

```bash
# Atualizar para versão específica
yarn add @felipeduarte26/waapi-module@x.x.x

# Limpar cache e rebuildar
yarn cache clean
cd android && ./gradlew clean && cd ..
yarn android
```

## 📞 9. Suporte

### 9.1. Logs Úteis

```bash
# Build com logs detalhados
yarn android --verbose

# Verificar configuração do Yarn
yarn config list

# Status do repositório GitHub Packages
curl -H "Authorization: token SEU_TOKEN" \
  https://api.github.com/users/felipeduarte26/packages
```

### 9.2. Contatos

- **Repositório**: https://github.com/felipeduarte26/waapi-flutter-module
- **Issues**: https://github.com/felipeduarte26/waapi-flutter-module/issues
- **Packages**: https://github.com/felipeduarte26/waapi-flutter-module/packages

## 📝 10. Changelog

| Versão | Data       | Mudanças                                       |
| ------ | ---------- | ---------------------------------------------- |
| 1.0.6  | 2024-12-16 | Primeira versão estável com todos os artefatos |
| 1.0.5  | 2024-12-16 | Correção de permissões GitHub Actions          |
| 1.0.4  | 2024-12-16 | Versioning dinâmico                            |

---

> 💡 **Dica**: Mantenha sempre o token GitHub seguro e nunca o commite no repositório público!
