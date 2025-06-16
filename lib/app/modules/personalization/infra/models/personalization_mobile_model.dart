import 'package:equatable/equatable.dart';

class PersonalizationMobileModel extends Equatable {
    final bool? usePersonalizationMobile;
    final String?  primaryColor;
    final String? secondaryColor;
    final bool?  useGradientColor;
    final bool?usePrimaryColorForPlatform;

  const PersonalizationMobileModel({
    this.usePersonalizationMobile,
    this.primaryColor,
    this.secondaryColor,
    this.useGradientColor,
    this.usePrimaryColorForPlatform,
  });


  factory PersonalizationMobileModel.empty() {
    return const PersonalizationMobileModel(
      usePersonalizationMobile: false,
      primaryColor: '',
      secondaryColor: '',
      useGradientColor: false,
      usePrimaryColorForPlatform: false,
    );
  }

  @override
  List<Object?> get props => [
        usePersonalizationMobile,
        primaryColor,
        secondaryColor,
        useGradientColor,
        usePrimaryColorForPlatform,
      ];
}
