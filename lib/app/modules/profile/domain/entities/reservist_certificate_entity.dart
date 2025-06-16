import 'package:equatable/equatable.dart';

class ReservistCertificateEntity extends Equatable {
  final String? id;
  final String? number;
  final String? category;

  const ReservistCertificateEntity({
    this.id,
    this.number,
    this.category,
  });

  @override
  List<Object?> get props {
    return [
      id,
      number,
      category,
    ];
  }
}
