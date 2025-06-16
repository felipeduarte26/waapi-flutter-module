import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/extension/string_extension.dart';

void main() {
  test(
    'Extension test.',
    () {
      expect('name'.capitalize(), 'Name');
      expect(''.toSentences, '');
      expect('name1-name2'.toSentences, 'Name1 Name2');
    },
  );
}
