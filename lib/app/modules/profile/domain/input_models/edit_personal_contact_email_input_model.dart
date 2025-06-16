import 'package:equatable/equatable.dart';

class EditPersonalContactEmailInputModel extends Equatable {
  final String? id;
  final String email;
  final String type;
  final String? originalType;
  final String? personRequestUpdateType;

  const EditPersonalContactEmailInputModel({
    this.id,
    required this.email,
    required this.type,
    this.originalType,
    this.personRequestUpdateType,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      type,
      originalType,
      personRequestUpdateType,
    ];
  }
}
