import 'package:equatable/equatable.dart';

class PhoneContactInputModel extends Equatable {
  final String? countryCode;
  final String? localCode;
  final String? provider;
  final String? number;
  final String? branch;

  const PhoneContactInputModel({
    this.countryCode,
    this.localCode,
    this.provider,
    this.number,
    this.branch,
  });

  @override
  List<Object?> get props {
    return [
      countryCode,
      localCode,
      provider,
      number,
      branch,
    ];
  }
}
