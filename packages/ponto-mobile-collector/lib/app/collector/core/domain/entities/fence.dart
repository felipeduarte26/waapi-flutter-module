import 'package:equatable/equatable.dart';
import 'perimeter.dart';

class Fence extends Equatable {
  final String? id;
  final String name;
  final List<Perimeter>? perimeters;

  const Fence({
    this.id,
    required this.name,
    this.perimeters,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        perimeters,
      ];
}
