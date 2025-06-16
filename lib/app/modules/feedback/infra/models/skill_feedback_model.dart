import 'package:equatable/equatable.dart';

class SkillFeedbackModel extends Equatable {
  final String id;
  final String name;

  const SkillFeedbackModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
    ];
  }
}
