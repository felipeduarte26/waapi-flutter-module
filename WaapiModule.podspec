Pod::Spec.new do |s|
  s.name             = 'WaapiModule'
  s.version          = '1.0.0'
  s.summary          = 'Flutter Waapi Module for React Native'
  s.description      = <<-DESC
    Wiipo Waapi Flutter module integration for React Native projects.
    This package contains the compiled Flutter module with all its dependencies
    as frameworks, ready to be consumed by React Native iOS apps.
                       DESC

  s.homepage         = 'https://github.com/wiipo/waapi-module'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wiipo' => 'dev@wiipo.com' }
  s.source           = { :git => 'https://github.com/wiipo/waapi-module.git', :tag => s.version.to_s }

  s.ios.deployment_target = '16.0'
  s.requires_arc = true

  # Incluir todos os frameworks do diretório ios/
  # O padrão de busca irá incluir tanto .framework quanto .xcframework
  s.ios.vendored_frameworks = 'ios/**/*.{framework,xcframework}'
  
  # Recursos adicionais (se necessário)
  # s.resource_bundles = {
  #   'WaapiModule' => ['ios/**/*.bundle']
  # }
  
  # Dependências do Flutter (básicas - serão resolvidas pelo Flutter)
  s.dependency 'Flutter'
  
  # Configurações de build
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'SWIFT_VERSION' => '5.0'
  }
  
  # Configurações específicas para suporte ao Flutter
  s.compiler_flags = '-DFLUTTER_FRAMEWORK=1'
  
  # Prevenção de conflitos de símbolos
  s.xcconfig = {
    'OTHER_LDFLAGS' => '-framework Flutter',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
  }
end 
