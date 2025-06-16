import 'package:equatable/equatable.dart';

import '../../enum/wage_type_enum.dart';

class PayrollWageTypeEntity extends Equatable {
  final String? id;
  final String? name;
  final WageTypeEnum? type;
  final String? kind;

  const PayrollWageTypeEntity({
    this.id,
    this.name,
    this.type,
    this.kind,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        kind,
      ];
}
