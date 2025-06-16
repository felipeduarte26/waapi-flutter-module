import 'package:equatable/equatable.dart';

class HappinessIndexReasonEntity extends Equatable {
  final String? id;
  final String? description;

  const HappinessIndexReasonEntity({
    this.id,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        description,
      ];
}
