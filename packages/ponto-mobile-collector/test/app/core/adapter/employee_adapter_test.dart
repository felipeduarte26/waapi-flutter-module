import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/adapters/employee_adapter.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/infra/models/employee_item_model.dart';

class MockEmployeeAdapter extends Mock
    implements EmployeeAdapter {}

void main() {
  group('EmployeeAdapter', () {
    test('toMap should return a valid Map', () {
      String jsonString = '{"employeesFacialAuthOn": [{"id": 1, "name": "John", "cpfNumber": "123456789"}]}';

      var result = EmployeeAdapter.toMap(jsonString);

      expect(result, isA<Map<String, dynamic>>());
    });

 test('fromJSON should return a list of EmployeeItemModel', () {
      String jsonString = '{"employeesFacialAuthOn": [{"id": "1", "name": "John", "cpfNumber": "123456789"}]}';

      var result = EmployeeAdapter.fromJSON(jsonString);

      expect(result, isA<List<EmployeeItemModel>>());
      expect(result.length, 1);
      expect(result[0].id, '1');
      expect(result[0].name, 'John');
      expect(result[0].identifier, '123456789');
    });

    test('getPageNumber should return the correct page number', () {
      String body = '{"pageNumber": 1}';

      var result = EmployeeAdapter.getPageNumber(body);

      expect(result, 1);
    });

    test('getPageSize should return the correct page size', () {
      String body = '{"pageSize": 10}';

      var result = EmployeeAdapter.getPageSize(body);

      expect(result, 10);
    });

    test('getTotalElements should return the correct total elements', () {
      String body = '{"totalElements": 100}';

      var result = EmployeeAdapter.getTotalElements(body);
      
      expect(result, 100);
    });
  });
}
