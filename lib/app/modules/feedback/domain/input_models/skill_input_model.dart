import 'package:equatable/equatable.dart';

class SkillInputModel extends Equatable {
  final String competencyId;
  final String skill;

  const SkillInputModel({
    required this.competencyId,
    required this.skill,
  });

  @override
  List<Object> get props {
    return [
      competencyId,
      skill,
    ];
  }
}
