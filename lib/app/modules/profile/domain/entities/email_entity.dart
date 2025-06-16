import 'package:equatable/equatable.dart';

import '../../enums/email_type_enum.dart';

class EmailEntity extends Equatable {
  final String? id;
  final String? email;
  final String? employeeId;
  final EmailTypeEnum? type;

  const EmailEntity({
    this.id,
    this.email,
    this.employeeId,
    this.type,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      employeeId,
      type,
    ];
  }
}
