import 'package:equatable/equatable.dart';

class SexualOrientationEntity extends Equatable {
  final String id;
  final String name;
  final int sequence;

  const SexualOrientationEntity({
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
