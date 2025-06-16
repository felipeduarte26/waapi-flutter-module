import 'package:equatable/equatable.dart';

class NationalityEntity extends Equatable {
  final String? id;
  final String? name;
  final int? code;

  const NationalityEntity({
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
