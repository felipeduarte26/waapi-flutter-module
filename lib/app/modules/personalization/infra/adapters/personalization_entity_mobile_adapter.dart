import '../../domain/entities/personalization_mobile_entity.dart';
import '../models/personalization_mobile_model.dart';


class PersonalizationMobileEntityAdapter {
  PersonalizationMobileEntity fromModel({
    required PersonalizationMobileModel personalizationMobileModel,
  }) {
    return PersonalizationMobileEntity(
      primaryColor: personalizationMobileModel.primaryColor,
      useGradientColor: personalizationMobileModel.useGradientColor,
      secondaryColor: personalizationMobileModel.secondaryColor,
      usePersonalizationMobile: personalizationMobileModel.usePersonalizationMobile,
      usePrimaryColorForPlatform: personalizationMobileModel.usePrimaryColorForPlatform,
    );
  }
}
