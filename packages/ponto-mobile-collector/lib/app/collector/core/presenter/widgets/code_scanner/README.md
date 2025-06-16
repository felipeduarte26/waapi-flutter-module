# Code Scanner

Componente que lida com toda a leitura e retorno do codigo contido no qrcode ou em um barcode.

##  Primeiros passos

É necessario adicionar algumas configuracoes no aplicativo base para que o componente tenha o correto acesso ao hardware:
#### iOS:
No arquivo Podfile
- muda a versao platform :ios para 14(ou maior)
- adicione essas configuracoes no post_install:
```
# add this line:
$iOSVersion = '14.0'  # ou qualquer versao acima

post_install do |installer|
  # add these lines:
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=*]"] = "armv7"
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
  end

  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    # add these lines:
    target.build_configurations.each do |config|
      if Gem::Version.new($iOSVersion) > Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'])
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $iOSVersion
      end
    end

  end
end
```
#### Android:
No arquivo `android/app/build.gradle` adicione essa configuracao ou qualquer versao acima:
- minSdkVersion: 21
- targetSdkVersion: 33
- compileSdkVersion: 33

### Como usar

Para usar o componente `CodeScannerWidget`:

```dart
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
```

Após isso adicione o widget `CodeScannerWidget` no local desejado.
O `CodeScannerWidget` tem um temporizador interno com padrao de `60 segundos` para encerrar o processo de leitura, esse tempo pode ser alterado via parametro.
Após o temporizador chegar ao limite será chamado o callback `onExpired:`.
O callback `onDetect:`fornece o retorno da leitura em ciclos de 1s enquanto o processo de leitura esta ativo ou seja enquanto o temporizador continua ativo.

```dart
    var code = 'scanning';

    void updateCode(String state) {
        setState(() {
        this.code = state;
        });
    }
    
    CodeScannerWidget(
        onDetect: (Barcode barcode) {
            this.updateCode(barcode.displayValue ?? 'Error Scanning');
        },
        onExpired: () {
            Navigator.of(context).pop();
        },
    ),
    
```
