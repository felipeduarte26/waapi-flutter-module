import 'package:equatable/equatable.dart';

class ReservistCertificateModel extends Equatable {
  final String? id;
  final String? number;
  final String? category;

  const ReservistCertificateModel({
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
