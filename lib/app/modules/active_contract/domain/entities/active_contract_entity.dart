import 'package:equatable/equatable.dart';

class ActiveContractEntity extends Equatable {
  final String employeeId;

  const ActiveContractEntity({
    required this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      employeeId,
    ];
  }
}
