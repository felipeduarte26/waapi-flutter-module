
import '../../../../core/types/either.dart';
import '../../domain/entities/personalization_mobile_entity.dart';
import '../../domain/failures/personalization_failure.dart';
import '../../domain/repositories/personalization_mobile_repository.dart';
import '../../domain/types/personalization_domain_types.dart';
import '../adapters/personalization_entity_mobile_adapter.dart';
import '../datasources/get_personalization_mobile_datasource.dart';
import '../driver/get_personalization_mobile_driver.dart';
import '../driver/save_personalization_mobile_driver.dart';
import '../models/personalization_mobile_model.dart';

class GetPersonalizationMobileRepositoryImp implements PersonalizationMobileRepository {
  final GetPersonalizationMobileDatasource _getPersonalizationMobileDatasource;
  final PersonalizationMobileEntityAdapter _personalizationMobileEntityAdapter;
 
  final GetPersonalizationMobileDriver _getPersonalizationMobileDriver;
  final SavePersonalizationMobileDriver _savePersonalizationMobileDriver;

  GetPersonalizationMobileRepositoryImp({
    required GetPersonalizationMobileDatasource getPersonalizationMobileDatasource,
    required PersonalizationMobileEntityAdapter personalizationMobileEntityAdapter,
    
    required GetPersonalizationMobileDriver getPersonalizationMobileDriver,
    required SavePersonalizationMobileDriver savePersonalizationMobileDriver,
  })  : _getPersonalizationMobileDatasource = getPersonalizationMobileDatasource,
        _personalizationMobileEntityAdapter = personalizationMobileEntityAdapter,
        
        _getPersonalizationMobileDriver = getPersonalizationMobileDriver,
        _savePersonalizationMobileDriver = savePersonalizationMobileDriver;

  @override
  GetPersonalizationMobileUsecaseCallback call() async {
    try {
      final personalizationMobileModel = await _getPersonalizationMobileDatasource.call().onError((error, stackTrace) {
        final personalizationMobileModelDriver = _getPersonalizationMobileDriver.call();
        return personalizationMobileModelDriver ?? PersonalizationMobileModel.empty();
      });

      _savePersonalizationMobileDriver(
        personalizationMobileModel: personalizationMobileModel,
      );
      return right(
        _personalizationMobileEntityAdapter.fromModel(
          personalizationMobileModel: personalizationMobileModel,
        ),
      );
    } catch (error) {


      return left(
        PersonalizationMobileDatasourceFailure(
          message: error.toString(),
          defaultPersonalizationMobileEntity: PersonalizationMobileEntity.empty(),
        ),
      );
    }
  }
}
