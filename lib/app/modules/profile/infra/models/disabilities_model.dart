import 'package:equatable/equatable.dart';

import 'disability_model.dart';

class DisabilitiesModel extends Equatable {
  final String? id;
  final DisabilityModel? disability;
  final bool? isRehabilitated;
  final bool? rehabilitation;
  final bool? mainDisability;

  const DisabilitiesModel({
    this.id,
    this.disability,
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
