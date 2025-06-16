import '../../infra/utils/enum/feature_toggle_enum.dart';
import '../enums/token_type.dart';

abstract class CheckFeatureToggleRepository {
  Future<bool> call({
    required FeatureToggleEnum featureToggle,
    required TokenType tokenType,
  });
}
