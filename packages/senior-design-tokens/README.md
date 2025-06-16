# Senior Design Tokens

Projeto com a implementação dos tokens do Senior Design System para aplicações móveis em Flutter. Disponibiliza tokens que definem espaçamentos, fontes, cores e outras constantes para os aplicativos.

## Primeiros passos

Para adicionar os tokens do Senior Design System na sua aplicação você pode usar diretamente o nosso pacote publicado no [Pub.dev](https://pub.dev/packages/senior_design_tokens). Adicione o pacote como uma dependência no seu arquivo *pubspec.yaml* ou utilize o comando `flutter pub add senior_design_tokens`.

### Como usar

Para usar os tokens no seu projeto você primeiramente precisa importar o nosso pacote de tokens.

```dart
import 'package:senior_design_tokens/senior_design_tokens.dart';
```

Após isso você já pode usar os tokens onde precisar. No exemplo abaixo está sendo atribuída a cor `primary-color` do Senior Design System a um Container.

```dart
Container(
    color: SeniorColors.primaryColor,
)
```

## Equipe e contribuições

Este projeto é desenvolvido e mantido pela equipe de design da Senior Sistemas e recebe contribuições de toda a equipe de desenvolvimento. Se desejar sugerir alguma implementação ou melhoria entre em contato com a nossa equipe 😉