import 'package:equatable/equatable.dart';

class ProficiencyFeedbackModel extends Equatable {
  final String id;
  final String icon;
  final String color;
  final String name;
  final String level;
  final bool needJustify;
  final bool needPDI;
  final double valueOfScore;

  const ProficiencyFeedbackModel({
    required this.id,
    required this.icon,
    required this.color,
    required this.name,
    required this.needJustify,
    required this.needPDI,
    required this.valueOfScore,
    required this.level,
  });

  @override
  List<Object?> get props {
    return [
      id,
      icon,
      color,
      name,
      level,
      needJustify,
      needPDI,
      valueOfScore,
    ];
  }
}
