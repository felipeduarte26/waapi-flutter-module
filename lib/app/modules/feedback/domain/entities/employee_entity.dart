import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final String id;
  final String name;
  final String username;
  final String nickname;
  final String photoUrl;

  const EmployeeEntity({
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
