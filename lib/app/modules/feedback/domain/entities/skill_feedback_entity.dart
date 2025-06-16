import 'package:equatable/equatable.dart';

class SkillFeedbackEntity extends Equatable {
  final String id;
  final String name;

  const SkillFeedbackEntity({
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
