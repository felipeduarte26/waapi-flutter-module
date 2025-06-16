import 'package:equatable/equatable.dart';

class GenderIdentityEntity extends Equatable {
  final String id;
  final String name;
  final int sequence;

  const GenderIdentityEntity({
    required this.id,
    required this.name,
    required this.sequence,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      sequence,
    ];
  }
}
