import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final String employeeId;
  final String username;
  final String name;
  final String photoLink;

  const EmployeeEntity({
    required this.employeeId,
    required this.username,
    required this.name,
    required this.photoLink,
  });

  String get firstName {
    return name.split(' ').first;
  }

  @override
  List<Object> get props {
    return [
      employeeId,
      username,
      name,
      photoLink,
    ];
  }
}
