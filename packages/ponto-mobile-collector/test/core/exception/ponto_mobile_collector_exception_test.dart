import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

void main() {
  test(
    'PontoMobileCollectorException test.',
    () {
      expect(
        PontoMobileCollectorException('erro').toString(),
        'PontoMobileCollectorException: erro',
      );
    },
  );
}
