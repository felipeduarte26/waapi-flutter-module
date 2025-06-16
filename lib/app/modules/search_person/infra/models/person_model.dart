import 'package:equatable/equatable.dart';

class PersonModel extends Equatable {
  final String employeeId;
  final String name;
  final String username;
  final String linkPhoto;
  final String jobPosition;

  const PersonModel({
    required this.employeeId,
    required this.name,
    required this.username,
    required this.linkPhoto,
    required this.jobPosition,
  });

  @override
  List<Object?> get props {
    return [
      employeeId,
      name,
      username,
      linkPhoto,
      jobPosition,
    ];
  }
}
