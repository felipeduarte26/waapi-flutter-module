
import 'package:equatable/equatable.dart';

import '../enums/geometric_form_type.dart';
import '../input_model/location_dto.dart';


class Perimeter extends Equatable {
  final String? id;
  final GeometricFormType? type;
  final LocationDto? startPoint;// validar usabilidade do enum
  final double radius;

  const Perimeter({
    this.id,
    this.startPoint,
    required this.radius,
    this.type,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        startPoint,
        radius,
      ];
}
