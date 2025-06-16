// ignore_for_file: implementation_imports

import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String? id;
  final String cnpj;
  final String? caepf;
  final String? cnoNumber;
  final String name;
  final String timeZone;
  final String? arpId;

  const Company({
    this.id,
    required this.cnpj,
    required this.name,
    required this.timeZone,
    this.arpId,
    this.cnoNumber,
    this.caepf,
  });

  @override
  List<Object?> get props => [
        id,
        cnpj,
        name,
        timeZone,
        arpId,
        cnoNumber,
        caepf,
      ];
}
