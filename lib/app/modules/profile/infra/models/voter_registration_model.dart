import 'package:equatable/equatable.dart';

class VoterRegistrationModel extends Equatable {
  final String? id;
  final String? number;
  final int? zone;
  final int? section;

  const VoterRegistrationModel({
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
