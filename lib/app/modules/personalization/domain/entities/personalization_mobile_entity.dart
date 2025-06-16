import 'package:equatable/equatable.dart';

class PersonalizationMobileEntity extends Equatable {
  final bool? usePersonalizationMobile;
  final String? primaryColor;
  final String? secondaryColor;
  final bool? useGradientColor;
  final bool? usePrimaryColorForPlatform;

  const PersonalizationMobileEntity({
    this.usePersonalizationMobile,
    this.primaryColor,
    this.secondaryColor,
    this.useGradientColor,
    this.usePrimaryColorForPlatform,
  });

  factory PersonalizationMobileEntity.empty() {
    return const PersonalizationMobileEntity(
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
