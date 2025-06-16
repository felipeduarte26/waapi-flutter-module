import 'package:equatable/equatable.dart';

class EducationDegreeEntity extends Equatable {
  final String? id;
  final String? name;
  final int? code;
  final String? type;

  const EducationDegreeEntity({
    this.id,
    this.name,
    this.code,
    this.type,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      code,
      type,
    ];
  }
}
