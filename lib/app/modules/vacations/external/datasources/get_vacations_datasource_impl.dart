import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../enums/vacation_period_situation_enum.dart';
import '../../infra/datasources/get_vacations_datasource.dart';
import '../../infra/models/vacations_model.dart';
import '../mappers/vacations_model_mapper.dart';

class GetVacationsDatasourceImpl implements GetVacationsDatasource {
  final RestService _restService;

  const GetVacationsDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<List<VacationsModel>> call({
    required String employeeId,
  }) async {
    final vacationPath = '/vacation/$employeeId';
    final vacationsResponse = await _restService.legacyManagementPanelService().get(vacationPath);

    List<VacationsModel> vacations = [];
    final vacationsResponseDecoded = jsonDecode(vacationsResponse.data!) as Map<String, dynamic>;

    if (vacationsResponseDecoded.containsKey('opened')) {
      for (final vacation in vacationsResponseDecoded['opened']) {
        vacations.add(
          VacationsModelMapper.fromMap(
            map: vacation,
            vacationPeriodSituation: VacationPeriodSituationEnum.opened,
            mapSignature: vacationsResponseDecoded.containsKey('vacationSignatureData')
                ? vacationsResponseDecoded['vacationSignatureData']
                : {},
          ),
        );
      }
    }

    if (vacationsResponseDecoded.containsKey('paid')) {
      for (final vacation in vacationsResponseDecoded['paid']) {
        vacations.add(
          VacationsModelMapper.fromMap(
            map: vacation,
            mapSignature: vacationsResponseDecoded.containsKey('vacationSignatureData')
                ? vacationsResponseDecoded['vacationSignatureData']
                : {},
            vacationPeriodSituation: VacationPeriodSituationEnum.paid,
          ),
        );
      }
    }

    return vacations;
  }
}
