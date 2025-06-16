import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'CollectorLocalizations test.',
    () {
      expect(
        () => lookupCollectorLocalizations(const Locale('xx')),
        throwsA(isA<FlutterError>()),
      );
    },
  );
}
