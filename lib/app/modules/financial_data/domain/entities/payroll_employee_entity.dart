import 'package:equatable/equatable.dart';

class PayrollEmployeeEntity extends Equatable {
  final String? id;

  const PayrollEmployeeEntity({
    this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
