import '../../infra/models/personalization_model.dart';

class PersonalizationModelMapper {
  PersonalizationModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PersonalizationModel(
      logoPreviewImageURL: map['logoPreviewImageURL'],
    );
  }
}
