import 'package:equatable/equatable.dart';

import 'diversity_person_model.dart';

class DiversityModel extends Equatable {
  final String? id;
  final String? personId;
  final DiversityPersonModel? diversity;

  const DiversityModel({
    required this.id,
    required this.personId,
    required this.diversity,
  });

  @override
  List<Object?> get props {
    return [
      id,
      personId,
      diversity,
    ];
  }
}
