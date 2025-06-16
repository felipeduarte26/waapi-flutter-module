import '../../../../core/types/either.dart';
import '../../domain/failures/happiness_index_failure.dart';
import '../../domain/repositories/happiness_index_is_enabled_repository.dart';
import '../../domain/types/happiness_index_domain_types.dart';
import '../datasources/happiness_index_is_enabled_datasource.dart';

class HappinessIndexIsEnabledRepositoryImpl implements HappinessIndexIsEnabledRepository {
  final HappinessIndexIsEnabledDatasource _happinessIndexIsEnabledDatasource;

  const HappinessIndexIsEnabledRepositoryImpl({
    required HappinessIndexIsEnabledDatasource happinessIndexIsEnabledDatasource,
  }) : _happinessIndexIsEnabledDatasource = happinessIndexIsEnabledDatasource;

  @override
  HappinessIndexIsEnabledUsecaseCallback call() async {
    try {
      final happinessIndexIsEnabled = await _happinessIndexIsEnabledDatasource.call();

      return right(happinessIndexIsEnabled);
    } catch (error) {
      return left(const HappinessIndexDatasourceFailure());
    }
  }
}
