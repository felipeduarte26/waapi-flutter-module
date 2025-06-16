#!/usr/bin/env node

/**
 * Script para configurar automaticamente o módulo Waapi no projeto React Native
 * 
 * Uso: node scripts/setup-waapi-module.js
 */

const fs = require('fs');
const path = require('path');

const GRADLE_FILE = 'android/app/build.gradle';
const WAAPI_REPO_LINE = '        url "$rootDir/../node_modules/@felipeduarte26/waapi-module/android/repo"';
const WAAPI_DEPENDENCIES = [
  '    debugImplementation \'com.wiipo.waapi_module:flutter_debug:1.0\'',
  '    profileImplementation \'com.wiipo.waapi_module:flutter_profile:1.0\'',
  '    releaseImplementation \'com.wiipo.waapi_module:flutter_release:1.0\''
];

function setupWaapiModule() {
  console.log('🚀 Configurando módulo Waapi...');

  // Verificar se o módulo está instalado
  const moduleExists = fs.existsSync('node_modules/@felipeduarte26/waapi-module');
  if (!moduleExists) {
    console.error('❌ Módulo @felipeduarte26/waapi-module não encontrado!');
    console.log('💡 Execute: yarn add @felipeduarte26/waapi-module@1.0.6');
    process.exit(1);
  }

  // Verificar se build.gradle existe
  if (!fs.existsSync(GRADLE_FILE)) {
    console.error(`❌ Arquivo ${GRADLE_FILE} não encontrado!`);
    process.exit(1);
  }

  // Ler arquivo atual
  let gradleContent = fs.readFileSync(GRADLE_FILE, 'utf8');

  // Verificar se já está configurado
  if (gradleContent.includes('@felipeduarte26/waapi-module')) {
    console.log('✅ Módulo Waapi já está configurado!');
    return;
  }

  let modified = false;

  // Adicionar repositório Maven
  if (gradleContent.includes('repositories {')) {
    const repoRegex = /(repositories\s*\{[^}]*)(})/;
    if (!gradleContent.includes('waapi-module/android/repo')) {
      gradleContent = gradleContent.replace(repoRegex, (match, repos, closing) => {
        return repos + '\n    maven {\n' + WAAPI_REPO_LINE + '\n    }\n' + closing;
      });
      modified = true;
      console.log('✅ Repositório Maven adicionado');
    }
  }

  // Adicionar dependências
  if (gradleContent.includes('dependencies {')) {
    const depsRegex = /(dependencies\s*\{[^}]*)(})/;
    let hasWaapiDeps = false;
    
    WAAPI_DEPENDENCIES.forEach(dep => {
      if (!gradleContent.includes(dep.trim())) {
        gradleContent = gradleContent.replace(depsRegex, (match, deps, closing) => {
          return deps + '\n\n    // Flutter Waapi Module\n' + dep + '\n' + closing;
        });
        hasWaapiDeps = true;
      }
    });

    if (hasWaapiDeps) {
      modified = true;
      console.log('✅ Dependências Waapi adicionadas');
    }
  }

  // Salvar arquivo se modificado
  if (modified) {
    fs.writeFileSync(GRADLE_FILE, gradleContent);
    console.log('🎉 Configuração concluída!');
    console.log('💡 Execute: yarn android');
  } else {
    console.log('ℹ️ Nenhuma modificação necessária');
  }
}

// Executar se chamado diretamente
if (require.main === module) {
  setupWaapiModule();
}

module.exports = { setupWaapiModule }; 
