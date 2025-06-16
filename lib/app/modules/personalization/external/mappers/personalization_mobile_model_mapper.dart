import '../../infra/models/personalization_mobile_model.dart';


class PersonalizationMobileModelMapper {
  PersonalizationMobileModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PersonalizationMobileModel(
      primaryColor: map['primaryColor'],
      useGradientColor: map['useGradientColor'],
      secondaryColor: map['secondaryColor'],
      usePersonalizationMobile: map['usePersonalizationMobile'],
      usePrimaryColorForPlatform: map['usePrimaryColorForPlatform'],

    );
  }
}
