import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

void main() {
  test(
    'ThemeData test.',
    () {
      expect(AppThemeData.themeData().primaryColor, SeniorColors.primaryColor);
    },
  );
}
