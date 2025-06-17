#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔧 Configurando Módulo Waapi...');

// Função para verificar se o arquivo existe
function fileExists(filePath) {
  try {
    return fs.statSync(filePath).isFile();
  } catch (err) {
    return false;
  }
}

// Função para verificar se o diretório existe
function dirExists(dirPath) {
  try {
    return fs.statSync(dirPath).isDirectory();
  } catch (err) {
    return false;
  }
}

// Encontrar o diretório raiz do projeto React Native
function findProjectRoot() {
  let currentDir = process.cwd();
  
  // Começar do node_modules e subir até encontrar package.json do projeto
  if (currentDir.includes('node_modules')) {
    // Estamos sendo executados do node_modules, subir até o projeto
    const parts = currentDir.split(path.sep);
    const nodeModulesIndex = parts.lastIndexOf('node_modules');
    currentDir = parts.slice(0, nodeModulesIndex).join(path.sep);
  }
  
  // Verificar se encontramos um projeto React Native
  while (currentDir !== path.dirname(currentDir)) {
    const packageJsonPath = path.join(currentDir, 'package.json');
    
    if (fileExists(packageJsonPath)) {
      try {
        const packageJson = JSON.parse(fs.readFileSync(packageJsonPath, 'utf8'));
        
        // Verificar se é um projeto React Native
        if (packageJson.dependencies && packageJson.dependencies['react-native']) {
          return currentDir;
        }
      } catch (err) {
        // Continuar procurando se não conseguir ler o package.json
      }
    }
    
    currentDir = path.dirname(currentDir);
  }
  
  return null;
}

// Função para verificar se uma string contém qualquer um dos padrões
function containsAnyPattern(content, patterns) {
  return patterns.some(pattern => content.includes(pattern));
}

// Função para adicionar conteúdo a uma seção específica do build.gradle
function addToGradleSection(content, sectionName, newContent) {
  const sectionRegex = new RegExp(`(${sectionName}\\s*\\{)([^{}]*(?:\\{[^}]*\\}[^{}]*)*)\\}`, 'g');
  const match = content.match(sectionRegex);
  
  if (match) {
    const fullMatch = match[0];
    const openingBrace = fullMatch.indexOf('{');
    const beforeClosing = fullMatch.lastIndexOf('}');
    
    const beforeContent = fullMatch.substring(0, beforeClosing);
    const newSection = beforeContent + `\n    ${newContent}\n}`;
    
    return content.replace(fullMatch, newSection);
  }
  
  return content;
}

function setupAndroid() {
  console.log('📱 Configurando integração Android...');
  
  const projectRoot = findProjectRoot();
  if (!projectRoot) {
    console.warn('⚠️  Não foi possível encontrar a raiz do projeto React Native. Configuração Android ignorada.');
    return;
  }
  
  const androidBuildGradle = path.join(projectRoot, 'android', 'app', 'build.gradle');
  
  if (!fileExists(androidBuildGradle)) {
    console.warn('⚠️  Arquivo build.gradle do Android não encontrado. Por favor, configure manualmente.');
    return;
  }
  
  try {
    let buildGradleContent = fs.readFileSync(androidBuildGradle, 'utf8');
    let modified = false;
    
    // Configuração do repositório Maven
    const mavenRepoConfig = `maven { url "$rootDir/../node_modules/@felipeduarte26/waapi-module/android/repo" }`;
    const mavenPatterns = [
      '@felipeduarte26/waapi-module/android/repo',
      '@wiipo/waapi-module/android/repo' // Manter compatibilidade com versão antiga
    ];
    
    // Verificar se o repositório Maven já existe
    if (!containsAnyPattern(buildGradleContent, mavenPatterns)) {
      console.log('🔍 Repositório Maven não encontrado, adicionando...');
      
      // Procurar pela seção repositories dentro de android
      const androidRepositoriesRegex = /(android\s*\{[\s\S]*?repositories\s*\{[^}]*)\}/;
      const androidMatch = buildGradleContent.match(androidRepositoriesRegex);
      
      if (androidMatch) {
        const newRepositories = androidMatch[1] + `\n        ${mavenRepoConfig}\n    }`;
        buildGradleContent = buildGradleContent.replace(androidRepositoriesRegex, newRepositories);
        console.log('✅ Repositório Maven adicionado à seção repositories do Android');
        modified = true;
      } else {
        // Procurar por repositories global
        const globalRepositoriesRegex = /(repositories\s*\{[^}]*)\}/;
        const globalMatch = buildGradleContent.match(globalRepositoriesRegex);
        
        if (globalMatch) {
          const newRepositories = globalMatch[1] + `\n    ${mavenRepoConfig}\n}`;
          buildGradleContent = buildGradleContent.replace(globalRepositoriesRegex, newRepositories);
          console.log('✅ Repositório Maven adicionado à seção repositories global');
          modified = true;
        } else {
          console.warn('⚠️  Não foi possível encontrar a seção repositories no build.gradle');
        }
      }
    } else {
      console.log('✅ Repositório Maven já existe');
    }
    
    // Configuração das dependências Flutter
    const flutterDependencies = [
      "debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'",
      "profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'",
      "releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'"
    ];
    
    const dependencyPatterns = [
      'com.wiipo.waapi_module:flutter_debug',
      'com.wiipo.waapi_module:flutter_profile',
      'com.wiipo.waapi_module:flutter_release'
    ];
    
    // Verificar quais dependências já existem
    const missingDependencies = [];
    flutterDependencies.forEach((dep, index) => {
      if (!buildGradleContent.includes(dependencyPatterns[index])) {
        missingDependencies.push(dep);
      }
    });
    
    if (missingDependencies.length > 0) {
      console.log(`🔍 Encontradas ${missingDependencies.length} dependências Flutter ausentes, adicionando...`);
      
      // Procurar pela seção dependencies
      const dependenciesRegex = /(dependencies\s*\{[^{}]*(?:\{[^}]*\}[^{}]*)*)\}/;
      const depMatch = buildGradleContent.match(dependenciesRegex);
      
      if (depMatch) {
        const existingDeps = depMatch[1];
        const newDependencies = existingDeps + '\n    ' + missingDependencies.join('\n    ') + '\n}';
        buildGradleContent = buildGradleContent.replace(dependenciesRegex, newDependencies);
        console.log(`✅ ${missingDependencies.length} dependências Flutter adicionadas ao build.gradle`);
        modified = true;
      } else {
        console.warn('⚠️  Não foi possível encontrar a seção dependencies no build.gradle');
      }
    } else {
      console.log('✅ Todas as dependências Flutter já existem');
    }
    
    // Salvar as mudanças se houve modificações
    if (modified) {
      // Fazer backup do arquivo original
      const backupPath = androidBuildGradle + '.backup.' + Date.now();
      fs.writeFileSync(backupPath, fs.readFileSync(androidBuildGradle));
      fs.writeFileSync(androidBuildGradle, buildGradleContent);
      console.log(`💾 Backup criado em ${path.basename(backupPath)}`);
      console.log('✅ Arquivo build.gradle do Android atualizado com sucesso');
    } else {
      console.log('✅ Configuração Android já está atualizada');
    }
    
  } catch (err) {
    console.error('❌ Erro ao configurar Android:', err.message);
  }
}

function setupIOS() {
  console.log('🍎 Configurando integração iOS...');
  
  const projectRoot = findProjectRoot();
  if (!projectRoot) {
    console.warn('⚠️  Não foi possível encontrar a raiz do projeto React Native. Configuração iOS ignorada.');
    return;
  }
  
  const podfilePath = path.join(projectRoot, 'ios', 'Podfile');
  
  if (!fileExists(podfilePath)) {
    console.warn('⚠️  Podfile não encontrado. Por favor, configure manualmente.');
    return;
  }
  
  try {
    let podfileContent = fs.readFileSync(podfilePath, 'utf8');
    let modified = false;
    
    // Configuração do pod com novo package name
    const podLine = "pod 'WaapiModule', :path => '../node_modules/@felipeduarte26/waapi-module'";
    const podPatterns = [
      '@felipeduarte26/waapi-module',
      '@wiipo/waapi-module', // Manter compatibilidade com versão antiga
      'WaapiModule'
    ];
    
    // Verificar se o pod já existe
    if (!containsAnyPattern(podfileContent, podPatterns)) {
      console.log('🔍 Pod WaapiModule não encontrado, adicionando...');
      
      // Encontrar onde adicionar o pod (após o target principal)
      const targetRegex = /target\s+['"][^'"]*['"][ \t]*do/;
      const match = podfileContent.match(targetRegex);
      
      if (match) {
        const insertIndex = podfileContent.indexOf(match[0]) + match[0].length;
        const beforeTarget = podfileContent.substring(0, insertIndex);
        const afterTarget = podfileContent.substring(insertIndex);
        
        podfileContent = beforeTarget + `\n  ${podLine}\n` + afterTarget;
        modified = true;
        console.log('✅ Pod WaapiModule adicionado ao Podfile');
      } else {
        console.warn('⚠️  Não foi possível encontrar a seção target no Podfile');
      }
    } else {
      console.log('✅ Pod WaapiModule já existe no Podfile');
    }
    
    // Salvar as mudanças se houve modificações
    if (modified) {
      // Fazer backup do arquivo original
      const backupPath = podfilePath + '.backup.' + Date.now();
      fs.writeFileSync(backupPath, fs.readFileSync(podfilePath));
      fs.writeFileSync(podfilePath, podfileContent);
      console.log(`💾 Backup criado em ${path.basename(backupPath)}`);
      console.log('✅ Podfile do iOS atualizado com sucesso');
      console.log('🔄 Execute "cd ios && pod install" para instalar o pod');
    } else {
      console.log('✅ Configuração iOS já está atualizada');
    }
    
  } catch (err) {
    console.error('❌ Erro ao configurar iOS:', err.message);
  }
}

function showInstructions() {
  console.log('\n📋 Resumo da Configuração:');
  console.log('');
  console.log('✅ Configuração automática do Módulo Waapi concluída!');
  console.log('');
  console.log('📱 Android:');
  console.log('  - Repositório Maven configurado automaticamente');
  console.log('  - Dependências Flutter (debug, profile, release) configuradas automaticamente');
  console.log('');
  console.log('🍎 iOS:');
  console.log('  - Pod WaapiModule configurado automaticamente');
  console.log('  - Execute "cd ios && pod install" se ainda não executou');
  console.log('');
  console.log('🔧 Configuração Manual (se a configuração automática falhou):');
  console.log('');
  console.log('Android (android/app/build.gradle):');
  console.log('  repositories {');
  console.log('    maven { url "$rootDir/../node_modules/@felipeduarte26/waapi-module/android/repo" }');
  console.log('  }');
  console.log('  dependencies {');
  console.log('    debugImplementation "com.wiipo.waapi_module:flutter_debug:1.0"');
  console.log('    profileImplementation "com.wiipo.waapi_module:flutter_profile:1.0"');
  console.log('    releaseImplementation "com.wiipo.waapi_module:flutter_release:1.0"');
  console.log('  }');
  console.log('');
  console.log('iOS (ios/Podfile):');
  console.log('  pod "WaapiModule", :path => "../node_modules/@felipeduarte26/waapi-module"');
  console.log('');
}

// Executar setup
try {
  setupAndroid();
  setupIOS();
  showInstructions();
} catch (err) {
  console.error('❌ Configuração falhou:', err.message);
  process.exit(1);
} 
