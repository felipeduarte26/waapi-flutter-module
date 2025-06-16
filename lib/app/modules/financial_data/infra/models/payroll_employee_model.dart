import 'package:equatable/equatable.dart';

class PayrollEmployeeModel extends Equatable {
  final String? id;

  const PayrollEmployeeModel({
    this.id,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
