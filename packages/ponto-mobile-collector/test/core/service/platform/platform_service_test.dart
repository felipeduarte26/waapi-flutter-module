import 'package:datetime_setting/datetime_setting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDatetimeSetting extends Mock implements DatetimeSetting {
  Future<bool> timeIsAuto() {
    return Future(() => true);
  }
}

void main() {
  test(
    'description',
    () async {
      
    },
  );
}
