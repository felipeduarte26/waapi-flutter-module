# Waapi Module

Flutter module para integração com React Native via GitHub Packages NPM.

## Sobre

Este módulo Flutter foi migrado de um projeto React Native para ser distribuído como package NPM independente. Ele contém todas as funcionalidades do Waapi compiladas para Android (AAR) e iOS (Frameworks).

## Instalação

Para usar este módulo em seu projeto React Native:

```bash
npm install @wiipo/waapi-module --registry=https://npm.pkg.github.com
```

Veja o [guia de integração completo](./INTEGRATION.md) para instruções detalhadas.

## Desenvolvimento

### Pré-requisitos

- Flutter 3.27.4+
- Xcode 14+ (para iOS)
- Android Studio com SDK 33+ (para Android)
- Node.js 14+ (para scripts NPM)

### Build Local

```bash
# Instalar dependências
flutter pub get

# Build completo (Android + iOS)
npm run build

# Build apenas Android
./scripts/android_build_module.sh

# Build apenas iOS (macOS only)
./scripts/build_modules_ios.sh
```

### Teste Local

```bash
# Criar package local para teste
npm pack

# Em outro projeto React Native
npm install ./waapi-module-1.0.0.tgz
```

## Pipeline CI/CD

O projeto usa GitHub Actions para:

1. Build automático do Flutter para Android e iOS
2. Publicação no GitHub Packages NPM
3. Criação de releases automáticas

### Triggers

- **Push para main**: Publica versão de desenvolvimento
- **Tags `v*`**: Publica versão estável
- **Pull Requests**: Executa testes de build

### Publicação

```bash
# Criar nova versão
git tag v1.0.1
git push origin v1.0.1

# Ou via commit na main (versão dev)
git push origin main
```

## Estrutura

```
waapi-module/
├── .github/workflows/    # Pipeline CI/CD
├── scripts/             # Scripts de build
├── android/            # Artifacts Android (gerados)
├── ios/                # Artifacts iOS (gerados)
├── lib/                # Código Flutter
├── packages/           # Dependências locais
└── [arquivos NPM]      # Configuração do package
```

## Links

- [Guia de Integração](./INTEGRATION.md)
- [GitHub Packages](https://github.com/wiipo/waapi-module/packages)
- [Documentação Flutter](https://flutter.dev/docs)
