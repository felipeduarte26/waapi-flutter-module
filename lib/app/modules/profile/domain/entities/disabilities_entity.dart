import 'package:equatable/equatable.dart';

import 'disability_entity.dart';

class DisabilitiesEntity extends Equatable {
  final String? id;
  final DisabilityEntity disability;
  final bool? isRehabilitated;
  final bool? rehabilitation;
  final bool? mainDisability;

  const DisabilitiesEntity({
    this.id,
    required this.disability,
    this.isRehabilitated,
    this.rehabilitation,
    this.mainDisability,
  });

  @override
  List<Object?> get props {
    return [
      id,
      disability,
      isRehabilitated,
      rehabilitation,
      mainDisability,
    ];
  }
}
