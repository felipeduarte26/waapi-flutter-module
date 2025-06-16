import 'package:equatable/equatable.dart';

import '../../enums/personal_request_update_status_enum.dart';

class PersonalRequestUpdateEntity extends Equatable {
  final String? id;
  final DateTime? date;
  final PersonalRequestUpdateStatusEnum? status;

  const PersonalRequestUpdateEntity({
    this.id,
    this.date,
    this.status,
  });

  @override
  List<Object?> get props {
    return [
      id,
      date,
      status,
    ];
  }
}
