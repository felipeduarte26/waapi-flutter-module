import 'package:equatable/equatable.dart';

import '../../enum/wage_type_enum.dart';

class PayrollWageTypeModel extends Equatable {
  final String? id;
  final String? name;
  final WageTypeEnum? type;
  final String? kind;

  const PayrollWageTypeModel({
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
