import 'package:equatable/equatable.dart';

class EmployeeItemModel extends Equatable {
  final String id;
  final String name;
  final String identifier;

  const EmployeeItemModel({
    required this.id,
    required this.name,
    required this.identifier,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        identifier,
      ];
}
