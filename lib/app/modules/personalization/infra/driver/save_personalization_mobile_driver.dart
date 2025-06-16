
import '../models/personalization_mobile_model.dart';

abstract class SavePersonalizationMobileDriver {
  Future<void> call({
    required PersonalizationMobileModel? personalizationMobileModel,
  });
}
