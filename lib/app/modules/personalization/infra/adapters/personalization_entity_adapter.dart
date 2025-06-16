import '../../domain/entities/personalization_entity.dart';
import '../models/personalization_model.dart';

class PersonalizationEntityAdapter {
  PersonalizationEntity fromModel({
    required PersonalizationModel personalizationModel,
  }) {
    return PersonalizationEntity(
      logoPreviewImageURL: personalizationModel.logoPreviewImageURL,
    );
  }
}
