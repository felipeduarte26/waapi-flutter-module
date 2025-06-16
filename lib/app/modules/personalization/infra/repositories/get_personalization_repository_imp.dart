import '../../../../core/types/either.dart';
import '../../domain/failures/personalization_failure.dart';
import '../../domain/repositories/personalization_repository.dart';
import '../../domain/types/personalization_domain_types.dart';
import '../adapters/personalization_entity_adapter.dart';
import '../datasources/get_personalization_datasource.dart';

class GetPersonalizationRepositoryImp implements PersonalizationRepository {
  final GetPersonalizationDatasource _getPersonalizationDatasource;
  final PersonalizationEntityAdapter _personalizationEntityAdapter;

  GetPersonalizationRepositoryImp({
    required GetPersonalizationDatasource getPersonalizationDatasource,
    required PersonalizationEntityAdapter personalizationEntityAdapter,
  })  : _getPersonalizationDatasource = getPersonalizationDatasource,
        _personalizationEntityAdapter = personalizationEntityAdapter;

  @override
  GetPersonalizationUsecaseCallback call() async {
    try {
      final personalizationModel = await _getPersonalizationDatasource.call();

      return right(
        _personalizationEntityAdapter.fromModel(
          personalizationModel: personalizationModel,
        ),
      );
    } catch (error) {
      return left(
        PersonalizationDatasourceFailure(
          message: error.toString(),
        ),
      );
    }
  }
}
