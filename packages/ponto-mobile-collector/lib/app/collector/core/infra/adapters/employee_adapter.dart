import 'dart:convert';

import '../../../modules/facial_recognition/infra/models/employee_item_model.dart';

class EmployeeAdapter {
  static Map<String, dynamic> toMap(String source) {
    return json.decode(source);
  }

   static List<EmployeeItemModel> fromJSON(String source) {
    // Converta a string para UTF-8 antes de decodificar
    List<int> utf8Bytes = source.toString().codeUnits;
    String utf8String = utf8.decode(utf8Bytes);

    // Decodifica o JSON de forma segura usando try-catch para capturar erros de decodificação
    try {
      var decodedJson = jsonDecode(utf8String);
      var employeesResult = decodedJson['employeesFacialAuthOn'];

      List<EmployeeItemModel> employeesList = [];

      for (var employee in employeesResult) {
        EmployeeItemModel employeeFacialAuth = EmployeeItemModel(
          id: employee['id'],
          name: employee['name'],
          identifier: employee['cpfNumber'],
        );
        employeesList.add(employeeFacialAuth);
      }

      return employeesList;
    } catch (e) {
      // Em caso de erro de decodificação, imprime o erro e retorna uma lista vazia
      return [];
    }
  }

  static int getPageNumber(String body) {
    var pageNumber = toMap(body)['pageNumber'];
    return pageNumber;
  }

  static int getPageSize(String body) {
    var pageSize = toMap(body)['pageSize'];
    return pageSize;
  }

  static int getTotalElements(String body) {
    var totalElements = toMap(body)['totalElements'];
    return totalElements;
  }
}
