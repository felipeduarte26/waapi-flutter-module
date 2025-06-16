import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_number_unread_notifications_datasource.dart';

class GetNumberUnreadNotificationsDatasourceImpl implements GetNumberUnreadNotificationsDatasource {
  final RestService _restService;

  const GetNumberUnreadNotificationsDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<int> call() async {
    final responseServer = await _restService.appEmployeeNotification().get('/queries/getNumberOfUnreadNotifications');

    final responseDecoded = jsonDecode(responseServer.data!);

    return responseDecoded['number'];
  }
}
