# Ponto Mobile Collector
**Objetivo**

Prover as funcionalidade de marcação de ponto de forma modularizada, possibilitando sua utilizaçao em diversas aplicações Flutter da Senior, atualmente [Ponto](https://git.senior.com.br/gestao-ponto/ponto-mobile) e [Waapi](https://git.senior.com.br/mobilidade/app-employee).

**Ambiente**

A configuração do ambiente de desenvolvimento, arquitetura, dicas e dúvidas seguem os mesmos passos do projeto do ponto, conforme sua [wiki](https://git.senior.com.br/gestao-ponto/ponto-mobile/-/wikis/home).

**Configurações especificas da plataforma**

* **Android**
    > No arquivo "android/app/build.gradle" corresponde as propriedades de minSdkVersion e da tag repositories, conforme exemplo: [build.gradle](https://git.senior.com.br/gestao-ponto/ponto-mobile/-/blob/feature/gpo-7161/android/app/build.gradle).

    > No arquivo "android/app/src/main/AndroidManifest.xml" corresponder as propriedades conforme exemplo: [AndroidManifest.xml](https://git.senior.com.br/gestao-ponto/ponto-mobile/-/blob/feature/gpo-7161/android/app/src/main/AndroidManifest.xml)

* **IOS**

   > No arquivo "ios/Runner/Info.plist" adicionar as sequintes permissões conforme exemplo: [Info.plist](https://git.senior.com.br/gestao-ponto/ponto-mobile/-/blob/feature/gpo-7161/ios/Runner/Info.plist)

   > No arquivo "ios/Podfile" corresponder as permissões conforme exemplo: [Podfile](https://git.senior.com.br/gestao-ponto/ponto-mobile-collector/-/blob/develop/example/ios/Podfile)

**Módulos**

O Coletor conta com três módulos atualmente:

* **PontoMobileCollectorModule**
    Módulo principal que importa todos os outros.
* **ClockingEventModule**
    Módulo de marcação de ponto.
* **TimeAdjustmentModule**
    Módulo de visualização e ajustes do ponto.

**Utilização**

No diretório do projeto é disponibilizado uma aplicaçao de exemplo servindo de base para configuração.

* **Importação**

    O módulo é disponibilizado via repositório do git, sendo necessário adicionar a seguinte referência em seu arquivo **pubspec.yaml**.

    ```yaml
        ponto_mobile_collector:
            git:
                url: https://git.senior.com.br/gestao-ponto/ponto-mobile-collector.git
                ref: develop # Branch ou Hash name
    ```

* **Senior Design System**
    
    Toda a interface do Coletor foi desenvolvido utilizando a biblioteca [SDS](https://git.senior.com.br/design/flutter-components), portanto, provê-la na sua raiz da árvore de widgets conforme abaixo:

    ```dart
        child: SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: const AppWidget(),
        ),
    ```

* **Senior Platform Authentication**

    O Coletor utiliza a biblioteca [Senior Platform Authentication](https://git.senior.com.br/arquitetura/senior-platform-authentication-ui), de modo que é preciso um usuário logado para acessar os recursos, portanto provê-la nos serviços da aplicação Pai.

* **Core Binds**
    
    No seu módulo principal, ou módulo que for encapsular o coletor, importar os binds de Serviços e Blocs:

    ```dart    
        @override
        List<Module> get imports => [
            PontoMobileCollectorBinds(),
            ClockingEventBinds(),
            TimeAdjustmentBinds(),
        ];
    ```
    
    **Obs.:** Independente de quais binds forem importados, sempre importar o bind principal `PontoMobileCollectorBinds`, que contem serviços necessários em todo os outros.

* **Câmera**

    Importar a rota da câmera no seu modulo raiz:
        
    ```dart
        ChildRoute(
          '/camera',
          child: (context, args) => CameraWidget(
            Modular.get<ISessionService>(),
            Modular.get<IUtils>(),
            Modular.get<ISharedPreferencesService>(),
          ),
        ),
    ```

    **Obs.:** Com exceção da câmera, todos os módulos usam rotas relativas internamente.

* **Traduções**

    Importar as traduções do Coletor:

    ```dart
        localizationsDelegates: const [
            CollectorLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
        ],
    ```

* **Inicializar**

    Chamar o método estático de inicialização antes de usar qualquer módulo ou serviço do Coletor.

    ```dart
        await CollectorModuleService.instance.initialize(
            required EnvironmentEnum environment, // Ambiente Test, Dev, Homolog ou Prod
            required AppIdentfierEnum appIdentifier, // Identificador da aplicação
            String fcmToken, // Opcional
            bool hideBackButton = true, // Exibe ou oculta botão de voltar 
            bool showNotificationButton = true, // Exibe ou oculta botão de notificações
        );
    ```

    **Importante**

    * Recomendamos chamar a função já na inicialização da aplicação após o login do usuário.
    * O Parâmetro **tokenFcm** é opcional, caso informado, o token será cadastrado para a aplicação recebe `push notification`.
    * Caso mudar o usuário logado da sua aplicação, chamar o metodo `finalize` e posteriormente o `initialize` com o novo usuário autenticado.

* **Finalizar**

    Chamar o método estático de finalização quando realizar logout ou encerrar a aplicação.

    ```dart
        await CollectorModuleService().finalize();
    ```
    