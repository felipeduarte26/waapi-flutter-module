import 'package:equatable/equatable.dart';

class NationalityModel extends Equatable {
  final String? id;
  final String? name;
  final int? code;

  const NationalityModel({
    this.id,
    this.name,
    this.code,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      code,
    ];
  }
}
