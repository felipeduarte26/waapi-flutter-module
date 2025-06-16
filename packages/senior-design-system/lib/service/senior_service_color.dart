import 'dart:math';

import 'package:flutter/material.dart';

class SeniorServiceColor {
  /// Método para determinar a melhor cor para os ícones de SquareButtons com base na
  /// relação de contraste com a cor de fundo fornecida.
  ///
  /// Parâmetros:
  /// - [color]: A cor de fundo do botão.
  /// - [lightColor]: A cor clara para comparação de contraste (padrão: branco).
  /// - [darkColor]: A cor escura para comparação de contraste (padrão: preto).
  /// - [isDisabled]: Indica se o botão está desabilitado; nesse caso, aplica opacidade de 0.3.
  ///
  /// Retorna:
  /// - A cor do ícone que possui o maior contraste e atende aos critérios de acessibilidade.
  static Color getColorSquareButtonsTheme({
    required Color color,
    Color lightColor = Colors.white,
    Color darkColor = Colors.black,
    bool isDisabled = false, // Aplica opacidade reduzida para botões desabilitados.
  }) {
    const double disabledOpacity = 0.3;
    const double darkColorEnabledOpacity = 0.7;
    const double whiteColorEnabledOpacity = 1.0;

    // Calcula a relação de contraste com as cores clara e escura.
    final double contrastWithLight = contrastRatio(color, lightColor);
    final double contrastWithDark = contrastRatio(color, darkColor);

    // Verifica qual cor possui contraste suficiente, com base no padrão WCAG.
    if (contrastWithLight >= 8) {
      // Retorna a cor clara se o contraste for suficiente.
      return lightColor.withOpacity(isDisabled ? disabledOpacity : whiteColorEnabledOpacity);
    }
    if (contrastWithDark >= 8) {
      // Retorna a cor escura se o contraste for suficiente, ajustando opacidade se desabilitado.
      return darkColor.withOpacity(isDisabled ? disabledOpacity : darkColorEnabledOpacity);
    }
    // Se nenhuma das cores atender ao critério de contraste, retorna a melhor disponível.
    return contrastWithLight > contrastWithDark
        ? lightColor.withOpacity(isDisabled ? disabledOpacity : whiteColorEnabledOpacity)
        : darkColor.withOpacity(isDisabled ? disabledOpacity : darkColorEnabledOpacity);
  }

  /// Calcula a relação de contraste entre duas cores, `bg` (background) e `fg` (foreground),
  /// com base na luminância relativa de cada cor. O valor retornado segue as diretrizes
  /// de acessibilidade WCAG, onde valores maiores indicam maior contraste.
  /// Útil para validar se o contraste atende aos padrões de acessibilidade.
  static double contrastRatio(Color bg, Color fg) {
    final double luminance1 = bg.computeLuminance();
    final double luminance2 = fg.computeLuminance();

    final double brightest = max(luminance1, luminance2);
    final double darkest = min(luminance1, luminance2);

    return (brightest + 0.05) / (darkest + 0.05);
  }

  /// Método para determinar a melhor cor de texto ou ícone em um botão com base na cor fornecida.
  ///
  /// Parâmetros:
  /// - [color]: A cor do botão para a qual será avaliada a cor de contraste.
  ///
  /// Lógica:
  /// - O método avalia o contraste da cor fornecida com a cor branca.
  /// - Retorna a cor do botão original se o contraste com branco for suficiente
  ///   (relacionado aos critérios de acessibilidade WCAG, com uma relação de contraste >= 8).
  /// - Caso contrário, retorna a cor preta para garantir a legibilidade.
  ///
  /// Retorna:
  /// - A cor do botão ou preto se o contraste com branco for insuficiente.
  static Color getContrastAdjustedColorTheme({required Color color}) {
    // Calcula o contraste da cor fornecida com a cor branca.
    final double contrastWithWhite = contrastRatio(color, Colors.white);
    const double contrastThreshold = 4;

    // Se o contraste com branco for suficiente (>= 8), retorna a própria cor fornecida.
    if (contrastWithWhite >= contrastThreshold) {
      return color; // Contraste suficiente com branco.
    }

    // Se o contraste com branco for insuficiente (< 8), retorna preto para garantir a legibilidade.
    return Colors.black;
  }

  static Color getOptimalContrastColorTheme({
    required Color color,
    Color lightColor = Colors.white,
    Color darkColor = Colors.black,
  }) {
    // Calcula a relação de contraste com as cores clara e escura.
    final double contrastWithLight = contrastRatio(color, lightColor);
    final double contrastWithDark = contrastRatio(color, darkColor);
    const double contrastThreshold = 8;

    // Verifica qual cor possui contraste suficiente, com base no padrão WCAG.
    if (contrastWithLight >= contrastThreshold) {
      // Retorna a cor clara se o contraste for suficiente.
      return lightColor;
    }

    if (contrastWithDark >= contrastThreshold) {
      // Retorna a cor escura se o contraste for suficiente, ajustando opacidade se desabilitado.
      return darkColor;
    }
    // Se nenhuma das cores atender ao critério de contraste, retorna a melhor disponível.
    return contrastWithLight > contrastWithDark ? lightColor : darkColor;
  }

  /// Converte uma string no formato `#RRGGBB` ou `#AARRGGBB` para um objeto [Color].
  ///
  /// - Se a string contiver 6 caracteres (`#RRGGBB`), será adicionada opacidade total (`FF`) automaticamente.
  /// - Se a string contiver 8 caracteres (`#AARRGGBB`), o valor de transparência fornecido será mantido.
  ///
  /// ### Exemplo de uso:
  /// ```dart
  /// String colorString = "#04221B";
  /// Color color = parseColor(colorString);
  /// print(color); // Saída: Color(0xFF04221B)
  /// ```
  ///
  /// - [colorString] deve começar com `#` seguido de 6 ou 8 caracteres hexadecimais.
  ///
  /// Retorna um objeto [Color] correspondente à cor fornecida.
  static Color parseColor(String colorString) {
    // Verifica se a string tem o caractere '#' e o remove
    String cleanedString = colorString.replaceFirst('#', '');

    // Se o comprimento for 6, adiciona o alpha "FF" (opacidade total)
    if (cleanedString.length == 6) {
      cleanedString = 'FF$cleanedString'; // Adiciona o valor alfa para opacidade total
    }

    // Converte a string para um inteiro hexadecimal e cria a cor
    return Color(int.parse(cleanedString, radix: 16));
  }
}
