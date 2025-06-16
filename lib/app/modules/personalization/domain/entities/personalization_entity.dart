import 'package:equatable/equatable.dart';

class PersonalizationEntity extends Equatable {
  final String? logoPreviewImageURL;

  const PersonalizationEntity({
    this.logoPreviewImageURL,
  });
  @override
  List<Object?> get props => [
        logoPreviewImageURL,
      ];
}
