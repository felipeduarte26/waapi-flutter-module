#!/usr/bin/env node

/**
 * Build script for Waapi Module
 * This script is used for local development and testing
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

console.log('🔨 Building Waapi Module...');

function executeCommand(command, description) {
  console.log(`\n🔄 ${description}...`);
  try {
    execSync(command, { stdio: 'inherit', cwd: process.cwd() });
    console.log(`✅ ${description} completed`);
    return true;
  } catch (error) {
    console.error(`❌ ${description} failed:`, error.message);
    return false;
  }
}

function checkPrerequisites() {
  console.log('🔍 Checking prerequisites...');
  
  // Check if Flutter is installed
  try {
    const output = execSync('flutter --version', { encoding: 'utf8' });
    console.log('✅ Flutter is installed');
    
    // Check Flutter version
    if (output.includes('3.27.4')) {
      console.log('✅ Flutter version 3.27.4 confirmed');
    } else {
      console.warn('⚠️  Expected Flutter 3.27.4, but found different version');
      console.log('Current version output:', output.split('\n')[0]);
    }
  } catch (error) {
    console.error('❌ Flutter is not installed or not in PATH');
    return false;
  }
  
  // Check if pubspec.yaml exists
  if (!fs.existsSync('pubspec.yaml')) {
    console.error('❌ pubspec.yaml not found. Make sure you are in the Flutter module directory');
    return false;
  }
  
  // Check if build scripts exist
  const androidScript = 'scripts/android_build_module.sh';
  const iosScript = 'scripts/build_modules_ios.sh';
  
  if (!fs.existsSync(androidScript)) {
    console.error(`❌ Android build script not found: ${androidScript}`);
    return false;
  }
  
  if (!fs.existsSync(iosScript)) {
    console.error(`❌ iOS build script not found: ${iosScript}`);
    return false;
  }
  
  console.log('✅ All prerequisites met');
  return true;
}

function buildAndroid() {
  console.log('\n📱 Building Android AAR...');
  
  // Make script executable
  execSync('chmod +x scripts/android_build_module.sh');
  
  return executeCommand(
    './scripts/android_build_module.sh',
    'Android AAR build'
  );
}

function buildIOS() {
  console.log('\n🍎 Building iOS Framework...');
  
  // Check if running on macOS
  if (process.platform !== 'darwin') {
    console.log('⚠️  iOS build skipped (not running on macOS)');
    return true;
  }
  
  // Make script executable
  execSync('chmod +x scripts/build_modules_ios.sh');
  
  return executeCommand(
    './scripts/build_modules_ios.sh',
    'iOS Framework build'
  );
}

function verifyBuilds() {
  console.log('\n🔍 Verifying builds...');
  
  let success = true;
  
  // Check Android build
  const androidRepo = 'build/host/outputs/repo';
  if (fs.existsSync(androidRepo)) {
    const aarFiles = execSync(`find ${androidRepo} -name "*.aar" | wc -l`, { encoding: 'utf8' }).trim();
    console.log(`✅ Android: Found ${aarFiles} AAR files`);
  } else {
    console.log('❌ Android: Repository directory not found');
    success = false;
  }
  
  // Check iOS build (only on macOS)
  if (process.platform === 'darwin') {
    const iosFrameworks = 'build/ios/framework';
    if (fs.existsSync(iosFrameworks)) {
      try {
        const frameworkFiles = execSync(`find ${iosFrameworks} -name "*.framework" -o -name "*.xcframework" | wc -l`, { encoding: 'utf8' }).trim();
        console.log(`✅ iOS: Found ${frameworkFiles} framework files`);
      } catch (error) {
        console.log('⚠️  iOS: Could not count framework files');
      }
    } else {
      console.log('❌ iOS: Framework directory not found');
      success = false;
    }
  }
  
  return success;
}

function createPackageStructure() {
  console.log('\n📦 Creating package structure...');
  
  // Create directories
  const dirs = ['android/repo', 'ios'];
  dirs.forEach(dir => {
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
      console.log(`📁 Created directory: ${dir}`);
    }
  });
  
  // Copy Android artifacts
  if (fs.existsSync('build/host/outputs/repo')) {
    console.log('📱 Copying Android artifacts...');
    executeCommand(
      'cp -r build/host/outputs/repo/* android/repo/',
      'Copy Android artifacts'
    );
  }
  
  // Copy iOS artifacts (only on macOS)
  if (process.platform === 'darwin' && fs.existsSync('build/ios/framework')) {
    console.log('🍎 Copying iOS artifacts...');
    executeCommand(
      'cp -r build/ios/framework/* ios/',
      'Copy iOS artifacts'
    );
  }
  
  console.log('✅ Package structure created');
}

// Main execution
async function main() {
  try {
    console.log('🚀 Starting Waapi Module build process...\n');
    
    // Check prerequisites
    if (!checkPrerequisites()) {
      process.exit(1);
    }
    
    // Build Android
    if (!buildAndroid()) {
      console.error('❌ Android build failed');
      process.exit(1);
    }
    
    // Build iOS (only on macOS)
    if (!buildIOS()) {
      console.error('❌ iOS build failed');
      process.exit(1);
    }
    
    // Verify builds
    if (!verifyBuilds()) {
      console.error('❌ Build verification failed');
      process.exit(1);
    }
    
    // Create package structure
    createPackageStructure();
    
    console.log('\n🎉 Build completed successfully!');
    console.log('\n📋 Next steps:');
    console.log('  1. Test the package locally: npm pack');
    console.log('  2. Push to repository to trigger CI/CD');
    console.log('  3. Create a release tag to publish to GitHub Packages');
    
  } catch (error) {
    console.error('❌ Build process failed:', error.message);
    process.exit(1);
  }
}

// Run if this script is called directly
if (require.main === module) {
  main();
}

module.exports = { main, buildAndroid, buildIOS }; 
