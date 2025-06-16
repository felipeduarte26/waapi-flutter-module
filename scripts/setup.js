#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

console.log('🔧 Setting up Waapi Module...');

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
  console.log('📱 Setting up Android integration...');
  
  const projectRoot = findProjectRoot();
  if (!projectRoot) {
    console.warn('⚠️  Could not find React Native project root. Android setup skipped.');
    return;
  }
  
  const androidBuildGradle = path.join(projectRoot, 'android', 'app', 'build.gradle');
  
  if (!fileExists(androidBuildGradle)) {
    console.warn('⚠️  Android build.gradle not found. Please configure manually.');
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
      console.log('🔍 Maven repository not found, adding...');
      
      // Procurar pela seção repositories dentro de android
      const androidRepositoriesRegex = /(android\s*\{[\s\S]*?repositories\s*\{[^}]*)\}/;
      const androidMatch = buildGradleContent.match(androidRepositoriesRegex);
      
      if (androidMatch) {
        const newRepositories = androidMatch[1] + `\n        ${mavenRepoConfig}\n    }`;
        buildGradleContent = buildGradleContent.replace(androidRepositoriesRegex, newRepositories);
        console.log('✅ Added Maven repository to android repositories section');
        modified = true;
      } else {
        // Procurar por repositories global
        const globalRepositoriesRegex = /(repositories\s*\{[^}]*)\}/;
        const globalMatch = buildGradleContent.match(globalRepositoriesRegex);
        
        if (globalMatch) {
          const newRepositories = globalMatch[1] + `\n    ${mavenRepoConfig}\n}`;
          buildGradleContent = buildGradleContent.replace(globalRepositoriesRegex, newRepositories);
          console.log('✅ Added Maven repository to global repositories section');
          modified = true;
        } else {
          console.warn('⚠️  Could not find repositories section in build.gradle');
        }
      }
    } else {
      console.log('✅ Maven repository already exists');
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
      console.log(`🔍 Found ${missingDependencies.length} missing Flutter dependencies, adding...`);
      
      // Procurar pela seção dependencies
      const dependenciesRegex = /(dependencies\s*\{[^{}]*(?:\{[^}]*\}[^{}]*)*)\}/;
      const depMatch = buildGradleContent.match(dependenciesRegex);
      
      if (depMatch) {
        const existingDeps = depMatch[1];
        const newDependencies = existingDeps + '\n    ' + missingDependencies.join('\n    ') + '\n}';
        buildGradleContent = buildGradleContent.replace(dependenciesRegex, newDependencies);
        console.log(`✅ Added ${missingDependencies.length} Flutter dependencies to build.gradle`);
        modified = true;
      } else {
        console.warn('⚠️  Could not find dependencies section in build.gradle');
      }
    } else {
      console.log('✅ All Flutter dependencies already exist');
    }
    
    // Salvar as mudanças se houve modificações
    if (modified) {
      // Fazer backup do arquivo original
      const backupPath = androidBuildGradle + '.backup.' + Date.now();
      fs.writeFileSync(backupPath, fs.readFileSync(androidBuildGradle));
      fs.writeFileSync(androidBuildGradle, buildGradleContent);
      console.log(`💾 Backup created at ${path.basename(backupPath)}`);
      console.log('✅ Android build.gradle updated successfully');
    } else {
      console.log('✅ Android configuration already up to date');
    }
    
  } catch (err) {
    console.error('❌ Error setting up Android:', err.message);
  }
}

function setupIOS() {
  console.log('🍎 Setting up iOS integration...');
  
  const projectRoot = findProjectRoot();
  if (!projectRoot) {
    console.warn('⚠️  Could not find React Native project root. iOS setup skipped.');
    return;
  }
  
  const podfilePath = path.join(projectRoot, 'ios', 'Podfile');
  
  if (!fileExists(podfilePath)) {
    console.warn('⚠️  Podfile not found. Please configure manually.');
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
      console.log('🔍 WaapiModule pod not found, adding...');
      
      // Encontrar onde adicionar o pod (após o target principal)
      const targetRegex = /target\s+['"][^'"]*['"][ \t]*do/;
      const match = podfileContent.match(targetRegex);
      
      if (match) {
        const insertIndex = podfileContent.indexOf(match[0]) + match[0].length;
        const beforeTarget = podfileContent.substring(0, insertIndex);
        const afterTarget = podfileContent.substring(insertIndex);
        
        podfileContent = beforeTarget + `\n  ${podLine}\n` + afterTarget;
        modified = true;
        console.log('✅ Added WaapiModule pod to Podfile');
      } else {
        console.warn('⚠️  Could not find target section in Podfile');
      }
    } else {
      console.log('✅ WaapiModule pod already exists in Podfile');
    }
    
    // Salvar as mudanças se houve modificações
    if (modified) {
      // Fazer backup do arquivo original
      const backupPath = podfilePath + '.backup.' + Date.now();
      fs.writeFileSync(backupPath, fs.readFileSync(podfilePath));
      fs.writeFileSync(podfilePath, podfileContent);
      console.log(`💾 Backup created at ${path.basename(backupPath)}`);
      console.log('✅ iOS Podfile updated successfully');
      console.log('🔄 Please run "cd ios && pod install" to install the pod');
    } else {
      console.log('✅ iOS configuration already up to date');
    }
    
  } catch (err) {
    console.error('❌ Error setting up iOS:', err.message);
  }
}

function showInstructions() {
  console.log('\n📋 Setup Summary:');
  console.log('');
  console.log('✅ Waapi Module automatic setup completed!');
  console.log('');
  console.log('📱 Android:');
  console.log('  - Maven repository configured automatically');
  console.log('  - Flutter dependencies (debug, profile, release) configured automatically');
  console.log('');
  console.log('🍎 iOS:');
  console.log('  - WaapiModule pod configured automatically');
  console.log('  - Run "cd ios && pod install" if you haven\'t already');
  console.log('');
  console.log('🔧 Manual Configuration (if automatic setup failed):');
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
  console.error('❌ Setup failed:', err.message);
  process.exit(1);
} 
