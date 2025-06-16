// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_moods_pulse_link_datasource.dart';

class GetMoodsPulseLinkDatasourceImpl implements GetMoodsPulseLinkDatasource {
  final RestService _restService;

  GetMoodsPulseLinkDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String userId,
  }) async {
    final response = await _restService.moodsService().get('/queries/getEmployeePulseLink?userId=$userId');

    final pulseLinkDecode = jsonDecode(
      response.data!,
    );

    return pulseLinkDecode['pulseLink'];
  }
}
