import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_personalization_datasource.dart';
import '../../infra/models/personalization_model.dart';
import '../mappers/personalization_model_mapper.dart';

class GetPersonalizationDatasourceImp implements GetPersonalizationDatasource {
  final RestService _restService;
  final PersonalizationModelMapper _personalizationModelMapper;

  GetPersonalizationDatasourceImp({
    required RestService restService,
    required PersonalizationModelMapper personalizationModelMapper,
  })  : _restService = restService,
        _personalizationModelMapper = personalizationModelMapper;

  @override
  Future<PersonalizationModel> call() async {

    final response = await _restService.personalizationService().get(
          '/queries/getCurrentPersonalizationSettings',
        );

    final personalizationDecode = jsonDecode(
      response.data!,
    );

    return _personalizationModelMapper.fromMap(
      map: personalizationDecode,
    );
  }
}
