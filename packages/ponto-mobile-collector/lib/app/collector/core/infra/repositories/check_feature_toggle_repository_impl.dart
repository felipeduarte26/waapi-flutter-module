

import '../../domain/enums/token_type.dart';
import '../../domain/repositories/check_feature_toggle_repository.dart';
import '../datasources/check_feature_toggle_datasource.dart';
import '../utils/enum/feature_toggle_enum.dart';

class CheckFeatureToggleRepositoryImpl implements CheckFeatureToggleRepository {
  final CheckFeatureToggleDatasource _checkFeatureToggleDatasource;

  const CheckFeatureToggleRepositoryImpl({
    required CheckFeatureToggleDatasource checkFeatureToggleDatasource,
  }) : _checkFeatureToggleDatasource = checkFeatureToggleDatasource;

  @override
  Future<bool> call({
    required FeatureToggleEnum featureToggle,
    required TokenType tokenType,
  }) async {
    return await _checkFeatureToggleDatasource.call(
      featureToggle: featureToggle,
      tokenType: tokenType,
    );
  }
}
