/**
 * Waapi Module - Flutter integration for React Native
 * @author Wiipo
 */

const path = require('path');
const fs = require('fs');

const packageJson = require('./package.json');

/**
 * Configurações do módulo Waapi
 */
const WaapiModule = {
  name: packageJson.name,
  version: packageJson.version,
  
  /**
   * Configurações Android
   */
  android: {
    // Caminho para o repositório Maven
    repoPath: path.join(__dirname, 'android', 'repo'),
    
    // Coordenadas Maven
    groupId: 'com.wiipo.waapi_module',
    artifactId: 'flutter',
    version: '1.0',
    
    // Dependências por build type
    dependencies: {
      debug: 'com.wiipo.waapi_module:flutter_debug:1.0',
      profile: 'com.wiipo.waapi_module:flutter_profile:1.0',
      release: 'com.wiipo.waapi_module:flutter_release:1.0'
    },
    
    /**
     * Retorna a configuração do repositório Maven para build.gradle
     */
    getRepositoryConfig() {
      return `maven { url "$rootDir/../node_modules/${packageJson.name}/android/repo" }`;
    },
    
    /**
     * Retorna as dependências para build.gradle
     */
    getDependencies() {
      return [
        `debugImplementation '${this.dependencies.debug}'`,
        `profileImplementation '${this.dependencies.profile}'`,
        `releaseImplementation '${this.dependencies.release}'`
      ];
    }
  },
  
  /**
   * Configurações iOS
   */
  ios: {
    // Caminho para os frameworks
    frameworkPath: path.join(__dirname, 'ios'),
    
    // Nome do Podspec
    podspecName: 'WaapiModule',
    
    /**
     * Retorna a configuração do pod para Podfile
     */
    getPodConfig() {
      return `pod '${this.podspecName}', :path => '../node_modules/${packageJson.name}'`;
    },
    
    /**
     * Lista os frameworks disponíveis
     */
    getFrameworks() {
      try {
        const frameworksPath = this.frameworkPath;
        if (!fs.existsSync(frameworksPath)) {
          return [];
        }
        
        const frameworks = [];
        const items = fs.readdirSync(frameworksPath);
        
        items.forEach(item => {
          const itemPath = path.join(frameworksPath, item);
          if (fs.statSync(itemPath).isDirectory() && 
              (item.endsWith('.framework') || item.endsWith('.xcframework'))) {
            frameworks.push({
              name: item,
              path: itemPath,
              type: item.endsWith('.xcframework') ? 'xcframework' : 'framework'
            });
          }
        });
        
        return frameworks;
      } catch (error) {
        console.warn('Warning: Could not list iOS frameworks:', error.message);
        return [];
      }
    }
  },
  
  /**
   * Informações do package
   */
  info: {
    description: packageJson.description,
    author: packageJson.author,
    license: packageJson.license,
    homepage: packageJson.homepage,
    repository: packageJson.repository
  },
  
  /**
   * Verifica se o módulo está instalado corretamente
   */
  isInstalled() {
    const androidRepo = fs.existsSync(this.android.repoPath);
    const iosFrameworks = fs.existsSync(this.ios.frameworkPath);
    
    return {
      android: androidRepo,
      ios: iosFrameworks,
      complete: androidRepo && iosFrameworks
    };
  },
  
  /**
   * Retorna informações de debug
   */
  getDebugInfo() {
    const installation = this.isInstalled();
    const iosFrameworks = this.ios.getFrameworks();
    
    return {
      package: {
        name: this.name,
        version: this.version
      },
      installation,
      android: {
        repoPath: this.android.repoPath,
        repoExists: installation.android,
        dependencies: this.android.dependencies
      },
      ios: {
        frameworkPath: this.ios.frameworkPath,
        frameworksExists: installation.ios,
        frameworks: iosFrameworks,
        podspecName: this.ios.podspecName
      }
    };
  }
};

module.exports = WaapiModule; 
