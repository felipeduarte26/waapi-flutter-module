import 'package:equatable/equatable.dart';

class HappinessIndexReasonModel extends Equatable {
  final String? id;
  final String? description;

  const HappinessIndexReasonModel({
    this.id,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        description,
      ];
}
