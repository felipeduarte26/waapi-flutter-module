import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  final String id;
  final String name;
  final String username;
  final String nickname;
  final String photoUrl;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.username,
    required this.nickname,
    required this.photoUrl,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      username,
      nickname,
      photoUrl,
    ];
  }
}
