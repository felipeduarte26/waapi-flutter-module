import 'dart:convert';
import 'dart:developer';

import '../../../../../ponto_mobile_collector.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../domain/usecases/get_environment_usecase.dart';
import '../../exception/multi_sync_employees_exception.dart';
import '../utils/constants/constants_path.dart';

class EmployeeSyncService implements IEmployeeSyncService {
  final IHttpClient httpClient;
  final IPlatformService platformService;
  final ISharedPreferencesService sharedPreferencesService;
  final GetEnvironmentUsecase getEnviromentUsecase;

  EmployeeSyncService({
    required this.httpClient,
    required this.platformService,
    required this.sharedPreferencesService,
    required this.getEnviromentUsecase,
  });

  @override
  Future<PageResponseEntity<MultiEmployeeSync>> getEmployees({
    required PageEntity pageEntity,
    String? employeeIdFilter,
  }) async {
    final enviroment = await getEnviromentUsecase.call();

    try {
      final url = Uri.https(
        enviroment.path,
        ConstantsPath.multiEmployeeSyncPath,
      );

      final deviceIdentifier = await _getDeviceIdentifier();

      Map<dynamic, dynamic> bodyMap = Map.from(
        {
          'identifier': deviceIdentifier,
          'pageInfo': {
            'page': pageEntity.page,
            'pageSize': pageEntity.pageSize,
          },
        },
      );

      if (employeeIdFilter != null && employeeIdFilter.isNotEmpty) {
        bodyMap['employeeIdFilter'] = employeeIdFilter;
      }

      final response = await httpClient.post(
        url.toString(),
        headers: _getRequestHeaders(),
        body: json.encode(bodyMap),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(
          utf8.decode(
            response.body.codeUnits,
          ),
        );
        List<dynamic> employees = map['employeeList'];
        if (employees.isNotEmpty) {
          List<MultiEmployeeSync> multiEmployeesSync = [];
          multiEmployeesSync =
              employees.map((e) => MultiEmployeeSync.fromJson(e)).toList();
          log('EmployeeSyncService: Multi Employees synchronization successful');

          return PageResponseEntity(
            content: multiEmployeesSync,
            pageNumber: map['pageData']['pageNumber'],
            totalElements: map['pageData']['totalElements'],
          );
        } else {
          log('EmployeeSyncService: Multi Employees sync returns empty');
        }
      } else {
        log('EmployeeSyncService: Multi Employees sync failed in status code');
        throw MultiSyncEmployeesException(message: 'Failed to synchronize employees.', statusCode: response.statusCode);
      }
    } catch (e) {
      log('EmployeeSyncService: Multi Employees sync failed, exception: ${e.toString()}');
      rethrow;
    }

    return PageResponseEntity(
      content: [],
      pageNumber: 0,
      totalElements: 0,
    );
  }

  Map<String, String> _getRequestHeaders() {
    return {
      'Accept': 'application/json;seniorx.version=3',
      'Content-Type': 'application/json',
    };
  }

  Future<String> _getDeviceIdentifier() async {
    final response = await platformService.getDeviceInfoDto();
    return response.identifier;
  }
}
