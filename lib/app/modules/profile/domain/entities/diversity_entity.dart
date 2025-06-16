import 'package:equatable/equatable.dart';

import 'diversity_person_entity.dart';

class DiversityEntity extends Equatable {
  final String? id;
  final String? personId;
  final DiversityPersonEntity? diversity;

  const DiversityEntity({
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
