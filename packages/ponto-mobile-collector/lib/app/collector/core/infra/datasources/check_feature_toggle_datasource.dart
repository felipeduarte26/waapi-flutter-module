import '../../domain/enums/token_type.dart';
import '../utils/enum/feature_toggle_enum.dart';

abstract class CheckFeatureToggleDatasource {
  Future<bool> call({
    required FeatureToggleEnum featureToggle,
    required TokenType tokenType,
  });
}
