# 📱 Wiipo Mobile Frontend

Aplicativo React Native da Wiipo com integração do módulo Flutter Waapi.

## 🎯 Sobre o Projeto

Este é o aplicativo mobile principal da Wiipo desenvolvido em React Native, que integra funcionalidades Flutter através do módulo Waapi distribuído via GitHub Packages NPM.

## 🚀 Quick Start

### Pré-requisitos

- **Node.js** 18+
- **Yarn** 3.6.4 (obrigatório)
- **React Native** 0.75+
- **Java** 17 (para Android)
- **Xcode** 14+ (para iOS)
- **Token GitHub** com permissões `read:packages`

### Instalação

```bash
# Clonar o repositório
git clone <repository-url>
cd wiipo-mobile-frontend

# Instalar dependências
yarn install

# Configurar módulo Waapi (veja documentação específica)
# docs/WAAPI_MODULE_QUICK_START.md

# Executar Android
yarn android

# Executar iOS
yarn ios
```

## 🔧 Módulo Waapi Flutter

Este projeto utiliza o módulo Waapi Flutter distribuído como package NPM no GitHub Packages.

### ⚡ Setup Rápido do Módulo Waapi

Para novos desenvolvedores que precisam configurar o módulo Waapi:

📖 **[Guia Rápido - 5 minutos](./docs/WAAPI_MODULE_QUICK_START.md)**

### 📚 Documentação Completa do Módulo Waapi

Para configuração completa, troubleshooting e configuração iOS:

📖 **[Documentação Completa](./docs/WAAPI_MODULE_SETUP.md)**

### Configuração Atual

- **Versão**: `@felipeduarte26/waapi-module@1.0.6`
- **Registry**: GitHub Packages NPM
- **Autenticação**: Token GitHub configurado em `.yarnrc.yml`

## 🏗️ Estrutura do Projeto

```
wiipo-mobile-frontend/
├── docs/                     # Documentação
│   ├── WAAPI_MODULE_SETUP.md    # Setup completo do módulo Waapi
│   └── WAAPI_MODULE_QUICK_START.md # Setup rápido
├── android/                  # Código nativo Android
├── ios/                      # Código nativo iOS
├── src/                      # Código React Native
├── node_modules/             # Dependências NPM
│   └── @felipeduarte26/waapi-module/ # Módulo Waapi Flutter
├── .yarnrc.yml              # Configuração Yarn + GitHub Packages
└── package.json             # Dependências e scripts
```

## 🔨 Scripts Disponíveis

```bash
# Desenvolvimento
yarn start          # Iniciar Metro bundler
yarn android        # Build e executar Android
yarn ios           # Build e executar iOS
yarn test          # Executar testes

# Limpeza
yarn clean         # Limpar cache React Native
yarn reset         # Reset completo (cache + node_modules)

# Análise
yarn lint          # Verificar código com ESLint
yarn type-check    # Verificar tipos TypeScript
```

## 🚀 Desenvolvimento

### Setup do Ambiente

1. **Clone e instale dependências**:

   ```bash
   git clone <repository-url>
   cd wiipo-mobile-frontend
   yarn install
   ```

2. **Configure o módulo Waapi**:

   - Siga o [Guia Rápido](./docs/WAAPI_MODULE_QUICK_START.md)
   - Configure token GitHub em `.yarnrc.yml`

3. **Execute o projeto**:
   ```bash
   yarn android  # ou yarn ios
   ```

### Troubleshooting Comum

| Problema                    | Solução                                       |
| --------------------------- | --------------------------------------------- |
| Erro de autenticação GitHub | Verificar token em `.yarnrc.yml`              |
| Módulo Waapi não encontrado | `yarn add @felipeduarte26/waapi-module@1.0.6` |
| Build Android falha         | Limpar cache: `cd android && ./gradlew clean` |
| Versão incompatível         | `adb uninstall com.wiipo && yarn android`     |

Para problemas específicos do módulo Waapi, consulte a [documentação completa](./docs/WAAPI_MODULE_SETUP.md).

## 🏢 Informações do Projeto

### Tecnologias Principais

- **React Native** 0.75+
- **TypeScript**
- **Yarn** 3.6.4 (com GitHub Packages)
- **Flutter Module** (Waapi via NPM)
- **Android** SDK 33+
- **iOS** 16.0+

### Dependências Especiais

- **@felipeduarte26/waapi-module**: Módulo Flutter compilado
- **@react-native-firebase**: Analytics, Crashlytics, Messaging
- **react-native-screens**: Navegação otimizada
- **react-native-keychain**: Armazenamento seguro

## 📞 Suporte

### Documentação

- 📖 [Setup Módulo Waapi - Rápido](./docs/WAAPI_MODULE_QUICK_START.md)
- 📖 [Setup Módulo Waapi - Completo](./docs/WAAPI_MODULE_SETUP.md)
- 📖 [Integração](./INTEGRATION.md) _(se disponível)_

### Links Úteis

- **Repositório Módulo Waapi**: https://github.com/felipeduarte26/waapi-flutter-module
- **GitHub Packages**: https://github.com/felipeduarte26/waapi-flutter-module/packages
- **React Native Docs**: https://reactnative.dev/docs/getting-started

### Versioning

- **App Version**: 3.8.4
- **Waapi Module**: 1.0.6
- **React Native**: 0.75+
- **Node.js**: 18+

---

> 💡 **Dica para novos desenvolvedores**: Comece com o [Guia Rápido do Waapi](./docs/WAAPI_MODULE_QUICK_START.md) para ter o ambiente funcionando em 5 minutos!
