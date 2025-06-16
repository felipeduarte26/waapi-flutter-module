import 'package:equatable/equatable.dart';

class PersonalizationModel extends Equatable {
  final String? logoPreviewImageURL;

  const PersonalizationModel({
    this.logoPreviewImageURL,
  });

  @override
  List<Object?> get props => [
        logoPreviewImageURL,
      ];
}
