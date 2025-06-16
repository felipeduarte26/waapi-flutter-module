import 'package:equatable/equatable.dart';

class ActiveContractModel extends Equatable {
  final String employeeId;

  const ActiveContractModel({
    required this.employeeId,
  });

  @override
  List<Object?> get props {
    return [
      employeeId,
    ];
  }
}
