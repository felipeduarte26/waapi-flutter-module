import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';

import '../../infra/datasources/get_personalization_mobile_datasource.dart';
import '../../infra/models/personalization_mobile_model.dart';

import '../mappers/personalization_mobile_model_mapper.dart';

class GetPersonalizationMobileDatasourceImp implements GetPersonalizationMobileDatasource {
  final RestService _restService;
  final PersonalizationMobileModelMapper _personalizationMobileModelMapper;

  GetPersonalizationMobileDatasourceImp({
    required RestService restService,
    required PersonalizationMobileModelMapper personalizationMobileModelMapper,
  })  : _restService = restService,
        _personalizationMobileModelMapper = personalizationMobileModelMapper;

  @override
  Future<PersonalizationMobileModel> call() async {
   
      final response = await _restService.personalizationMobileService().get(
            '/queries/getCurrentPersonalizationMobileSettings',           
          ).timeout(
            const Duration(seconds: 15),
          );

      final personalizationMobileDecode = jsonDecode(
        response.data!,
      );

      return _personalizationMobileModelMapper.fromMap(
        map: personalizationMobileDecode,
      );
  }
}
