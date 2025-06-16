import 'package:equatable/equatable.dart';
import 'employee.dart';
import 'platform_user.dart';

class ManagerEmployee extends Equatable {
  final String? id;
  final String? mail;
  final List<PlatformUser>? platformUsers;
  final String? platformUserName;
  final List<Employee>? employees;

  const ManagerEmployee({
    this.id,
    this.mail,
    this.platformUsers,
    this.platformUserName,
    this.employees,
  });

  @override
  List<Object?> get props => [
        id,
        mail,
        platformUsers,
        platformUserName,
        employees,
      ];
}
