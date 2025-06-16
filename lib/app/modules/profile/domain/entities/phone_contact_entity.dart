import 'package:equatable/equatable.dart';

import '../../enums/phone_contact_type_enum.dart';

class PhoneContactEntity extends Equatable {
  final String? id;
  final PhoneContactTypeEnum? type;
  final int? countryCode;
  final int? localCode;
  final String? provider;
  final String? number;
  final String? branch;

  const PhoneContactEntity({
    this.id,
    this.type,
    this.countryCode,
    this.localCode,
    this.provider,
    this.number,
    this.branch,
  });

  @override
  List<Object?> get props {
    return [
      id,
      type,
      countryCode,
      localCode,
      provider,
      number,
      branch,
    ];
  }
}
