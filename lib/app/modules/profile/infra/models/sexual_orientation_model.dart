import 'package:equatable/equatable.dart';

class SexualOrientationModel extends Equatable {
  final String id;
  final String name;
  final int sequence;

  const SexualOrientationModel({
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
