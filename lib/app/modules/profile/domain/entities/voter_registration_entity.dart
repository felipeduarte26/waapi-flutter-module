import 'package:equatable/equatable.dart';

class VoterRegistrationEntity extends Equatable {
  final String? id;
  final String? number;
  final int? zone;
  final int? section;

  const VoterRegistrationEntity({
    this.id,
    this.number,
    this.zone,
    this.section,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      zone,
      section,
    ];
  }
}
