# Senior Design System

Projeto com a implementação dos componente do Senior Design System para aplicações móveis em Flutter. Disponibiliza uma série de componentes que podem ser usados na interfaces dos aplicativos.

##  Primeiros passos

Para adicionar o Senior Design System na sua aplicação você pode usar diretamente o nosso pacote publicado no [Pub.dev](https://pub.dev/packages/senior_design_system). Adicione o pacote como uma dependência no seu arquivo pubspec.yaml ou utilize o comando ```flutter pub add senior_design_system```.

Temos outro pacote para os nossos tokens que recomendamos adicionar no projeto também. Você pode encontrá-lo também no Pub.dev como [senior_design_tokens](https://pub.dev/packages/senior_design_tokens).

### Como usar

Para usar os nossos componentes no seu projeto você primeiramente precisa importar o nosso pacote e o pacote de tokens.

```dart
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
```

Após isso adicione o widget SeniorDesignSystem no ponto mais alto possível da sua árvore de widgets. Este widget irá adicionar configurações necessárias para os componentes na sua aplicações e também disponibilizará um gerenciamento de temas próprio dos componentes do Senior Design System.

```dart
void main() {
    runApp(
        SeniorDesignSystem(
            theme: SENIOR_LIGHT_THEME,
            child: MyApp(),
        ),
    );
}
```

Agora você só precisa adicionar o componente que quiser onde precisar! No exemplo abaixo estamos adicionando o componente SeniorButton dentro de um componente chamado Panel, um componente genérico para este exemplo.

```dart
Panel(
    title: 'Primary button',
    child: SeniorButton(
        label: 'Salvar',
        onPressed: () => _showSnackbar(
            context: context,
            message: 'Clicou sobre o botão Salvar!',
        ),
        disabled: _isDisabled,
        fullLength: true,
        size: SeniorButtonSize.big,
        type: SeniorButtonType.primary,
    ),
),
```

## Equipe e contribuições

Este projeto é desenvolvido e mantido pela equipe de design da Senior Sistemas e recebe contribuições de toda a equipe de desenvolvimento. Se desejar sugerir alguma implementação ou melhoria entre em contato com a nossa equipe 😉