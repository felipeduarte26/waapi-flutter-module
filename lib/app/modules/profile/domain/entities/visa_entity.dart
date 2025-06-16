import 'package:equatable/equatable.dart';

import '../../enums/visa_type_enum.dart';

class VisaEntity extends Equatable {
  final String? number;
  final DateTime? issuedDate;
  final DateTime? expiryDate;
  final VisaTypeEnum? visaType;

  const VisaEntity({
    this.number,
    this.issuedDate,
    this.expiryDate,
    this.visaType,
  });

  @override
  List<Object?> get props {
    return [
      number,
      issuedDate,
      expiryDate,
      visaType,
    ];
  }
}
