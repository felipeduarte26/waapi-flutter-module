// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class EmployeeItemEntity extends Equatable {
  final String id;
  final String name;
  final String identifier;
  bool? employeeSelected;

  EmployeeItemEntity({
    required this.id,
    required this.name,
    required this.identifier,
    this.employeeSelected = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        identifier,
        employeeSelected,
      ];
}
