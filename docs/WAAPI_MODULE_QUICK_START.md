# ⚡ Waapi Module - Quick Start

Guia rápido para configurar o módulo Waapi Flutter no projeto React Native.

## 🚀 Setup Rápido (5 minutos)

### 1. Configure o GitHub Token

```bash
# Edite .yarnrc.yml na raiz do projeto
echo "npmScopes:
  felipeduarte26:
    npmRegistryServer: https://npm.pkg.github.com
    npmAuthToken: SEU_GITHUB_TOKEN" >> .yarnrc.yml
```

### 2. Instale o Módulo

```bash
yarn add @felipeduarte26/waapi-module@1.0.6
```

### 3. Configure Android

🎉 **Configuração automática!** O script `postinstall` já configurou o `android/app/build.gradle`:

✅ **Repositório Maven** adicionado automaticamente  
✅ **Dependências Flutter** (debug, profile, release) adicionadas automaticamente

💡 **Se por algum motivo não funcionou**, configure manualmente:

<details>
<summary>📖 Configuração Manual (clique para expandir)</summary>

```gradle
repositories {
    maven {
        url "$rootDir/../node_modules/@felipeduarte26/waapi-module/android/repo"
    }
}

dependencies {
    debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'
    profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'
    releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'
}
```

</details>

### 4. Teste

```bash
yarn android
```

## ✅ Verificação Rápida

- [ ] Token GitHub configurado em `.yarnrc.yml`
- [ ] Módulo instalado: `ls node_modules/@felipeduarte26/waapi-module`
- [ ] ✨ Configuração automática executada (repositório + dependências)
- [ ] Build Android funciona: `yarn android`

### 🔍 Verificar se a configuração automática funcionou:

```bash
# Verificar repositório Maven
grep "felipeduarte26/waapi-module" android/app/build.gradle

# Verificar dependências Flutter
grep "flutter_debug\|flutter_profile\|flutter_release" android/app/build.gradle
```

## 🔗 Documentação Completa

Para configuração completa, troubleshooting e configuração iOS, veja:
📖 [**Documentação Completa**](./WAAPI_MODULE_SETUP.md)

## 🆘 Problemas Comuns

| Erro                | Solução Rápida                            |
| ------------------- | ----------------------------------------- |
| `404 Not Found`     | Verificar token GitHub em `.yarnrc.yml`   |
| `Could not resolve` | Verificar caminho Maven no `build.gradle` |
| `Version downgrade` | `adb uninstall com.wiipo && yarn android` |
