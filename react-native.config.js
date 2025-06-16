/**
 * React Native configuration for Waapi Module
 */

module.exports = {
  dependency: {
    platforms: {
      android: {
        // Configurações específicas do Android
        sourceDir: '../android',
        packageImportPath: 'import com.wiipo.waapi_module.WaapiModulePlugin;',
        
        // Gradle configurations
        gradleScript: {
          repositories: [
            'maven { url "$rootDir/../node_modules/@wiipo/waapi-module/android/repo" }'
          ],
          dependencies: [
            'debugImplementation "com.wiipo.waapi_module:flutter_debug:1.0"',
            'profileImplementation "com.wiipo.waapi_module:flutter_profile:1.0"', 
            'releaseImplementation "com.wiipo.waapi_module:flutter_release:1.0"'
          ]
        }
      },
      ios: {
        // Configurações específicas do iOS
        podspecPath: '../WaapiModule.podspec',
        
        // Podfile configurations
        podfile: {
          dependencies: [
            "pod 'WaapiModule', :path => '../node_modules/@wiipo/waapi-module'"
          ]
        }
      },
    },
  },
  
  // Assets do módulo (se houver)
  assets: [],
  
  // Comandos customizados
  commands: [
    {
      name: 'waapi-info',
      description: 'Show Waapi Module information',
      func: () => {
        const WaapiModule = require('./index.js');
        const debugInfo = WaapiModule.getDebugInfo();
        
        console.log('\n📦 Waapi Module Information:');
        console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
        
        console.log(`\n🏷️  Package: ${debugInfo.package.name}@${debugInfo.package.version}`);
        
        console.log('\n📱 Installation Status:');
        console.log(`  Android: ${debugInfo.installation.android ? '✅ Installed' : '❌ Missing'}`);
        console.log(`  iOS: ${debugInfo.installation.ios ? '✅ Installed' : '❌ Missing'}`);
        console.log(`  Complete: ${debugInfo.installation.complete ? '✅ Ready' : '⚠️  Incomplete'}`);
        
        console.log('\n🤖 Android Configuration:');
        console.log(`  Repository Path: ${debugInfo.android.repoPath}`);
        console.log(`  Repository Exists: ${debugInfo.android.repoExists ? '✅' : '❌'}`);
        console.log('  Dependencies:');
        Object.entries(debugInfo.android.dependencies).forEach(([type, dep]) => {
          console.log(`    ${type}: ${dep}`);
        });
        
        console.log('\n🍎 iOS Configuration:');
        console.log(`  Framework Path: ${debugInfo.ios.frameworkPath}`);
        console.log(`  Frameworks Exist: ${debugInfo.ios.frameworksExists ? '✅' : '❌'}`);
        console.log(`  Podspec Name: ${debugInfo.ios.podspecName}`);
        console.log(`  Frameworks (${debugInfo.ios.frameworks.length}):`);
        debugInfo.ios.frameworks.forEach(framework => {
          console.log(`    ${framework.name} (${framework.type})`);
        });
        
        if (!debugInfo.installation.complete) {
          console.log('\n⚠️  Setup Issues Detected:');
          if (!debugInfo.installation.android) {
            console.log('  - Android repository missing. Run: npm install @wiipo/waapi-module');
          }
          if (!debugInfo.installation.ios) {
            console.log('  - iOS frameworks missing. Run: npm install @wiipo/waapi-module');
          }
          console.log('  - Run setup script: node node_modules/@wiipo/waapi-module/scripts/setup.js');
        }
        
        console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
      }
    }
  ]
}; 
