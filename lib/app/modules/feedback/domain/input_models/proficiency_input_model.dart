import 'package:equatable/equatable.dart';

class ProficiencyInputModel extends Equatable {
  final String id;
  final String color;
  final String name;
  final String level;

  const ProficiencyInputModel({
    required this.id,
    required this.color,
    required this.name,
    required this.level,
  });

  @override
  List<Object?> get props {
    return [
      id,
      color,
      name,
      level,
    ];
  }
}
