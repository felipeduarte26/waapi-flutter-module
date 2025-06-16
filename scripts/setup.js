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
    
    // Adicionar repositório Maven se não existir
    const mavenRepoConfig = `maven { url "$rootDir/../node_modules/@wiipo/waapi-module/android/repo" }`;
    
    if (!buildGradleContent.includes('@wiipo/waapi-module/android/repo')) {
      // Encontrar a seção repositories e adicionar o repositório
      const repositoriesRegex = /(repositories\s*\{[^}]*)\}/;
      const match = buildGradleContent.match(repositoriesRegex);
      
      if (match) {
        const newRepositories = match[1] + `\n    ${mavenRepoConfig}\n}`;
        buildGradleContent = buildGradleContent.replace(repositoriesRegex, newRepositories);
        
        console.log('✅ Added Maven repository to build.gradle');
      } else {
        console.warn('⚠️  Could not find repositories section in build.gradle');
      }
    }
    
    // Verificar se as dependências já existem
    const dependencies = [
      "debugImplementation 'com.wiipo.waapi_module:flutter_debug:1.0'",
      "profileImplementation 'com.wiipo.waapi_module:flutter_profile:1.0'",
      "releaseImplementation 'com.wiipo.waapi_module:flutter_release:1.0'"
    ];
    
    let dependenciesAdded = false;
    dependencies.forEach(dep => {
      if (!buildGradleContent.includes(dep)) {
        // Encontrar a seção dependencies e adicionar
        const dependenciesRegex = /(dependencies\s*\{[^}]*)\}/;
        const depMatch = buildGradleContent.match(dependenciesRegex);
        
        if (depMatch) {
          const newDependencies = depMatch[1] + `\n    ${dep}\n}`;
          buildGradleContent = buildGradleContent.replace(dependenciesRegex, newDependencies);
          dependenciesAdded = true;
        }
      }
    });
    
    if (dependenciesAdded) {
      // Fazer backup do arquivo original
      fs.writeFileSync(androidBuildGradle + '.backup', fs.readFileSync(androidBuildGradle));
      fs.writeFileSync(androidBuildGradle, buildGradleContent);
      console.log('✅ Added Flutter dependencies to build.gradle');
      console.log('💾 Backup created at build.gradle.backup');
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
    
    // Adicionar pod se não existir
    const podLine = "pod 'WaapiModule', :path => '../node_modules/@wiipo/waapi-module'";
    
    if (!podfileContent.includes('WaapiModule')) {
      // Encontrar onde adicionar o pod (após outros pods)
      const targetRegex = /target ['"][^'"]*['"] do/;
      const match = podfileContent.match(targetRegex);
      
      if (match) {
        const insertIndex = podfileContent.indexOf(match[0]) + match[0].length;
        const beforeTarget = podfileContent.substring(0, insertIndex);
        const afterTarget = podfileContent.substring(insertIndex);
        
        podfileContent = beforeTarget + `\n  ${podLine}\n` + afterTarget;
        
        // Fazer backup do arquivo original
        fs.writeFileSync(podfilePath + '.backup', fs.readFileSync(podfilePath));
        fs.writeFileSync(podfilePath, podfileContent);
        
        console.log('✅ Added WaapiModule pod to Podfile');
        console.log('💾 Backup created at Podfile.backup');
        console.log('🔄 Please run "cd ios && pod install" to install the pod');
      } else {
        console.warn('⚠️  Could not find target section in Podfile');
      }
    } else {
      console.log('✅ WaapiModule pod already exists in Podfile');
    }
    
  } catch (err) {
    console.error('❌ Error setting up iOS:', err.message);
  }
}

function showInstructions() {
  console.log('\n📋 Setup Instructions:');
  console.log('');
  console.log('For Android:');
  console.log('  - Repository and dependencies should be automatically added to build.gradle');
  console.log('  - If not, manually add to android/app/build.gradle:');
  console.log('    repositories {');
  console.log('      maven { url "$rootDir/../node_modules/@wiipo/waapi-module/android/repo" }');
  console.log('    }');
  console.log('    dependencies {');
  console.log('      debugImplementation "com.wiipo.waapi_module:flutter_debug:1.0"');
  console.log('      profileImplementation "com.wiipo.waapi_module:flutter_profile:1.0"');
  console.log('      releaseImplementation "com.wiipo.waapi_module:flutter_release:1.0"');
  console.log('    }');
  console.log('');
  console.log('For iOS:');
  console.log('  - Pod should be automatically added to Podfile');
  console.log('  - Run: cd ios && pod install');
  console.log('  - If not added automatically, manually add to ios/Podfile:');
  console.log('    pod "WaapiModule", :path => "../node_modules/@wiipo/waapi-module"');
  console.log('');
  console.log('✅ Waapi Module setup completed!');
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
