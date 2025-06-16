import 'package:equatable/equatable.dart';

import '../../enums/visa_type_enum.dart';

class VisaModel extends Equatable {
  final String? number;
  final DateTime? issuedDate;
  final DateTime? expiryDate;
  final VisaTypeEnum? visaType;

  const VisaModel({
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
