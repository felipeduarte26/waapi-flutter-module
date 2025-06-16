import 'package:equatable/equatable.dart';

class HistoricalJobPositionEntity extends Equatable {
  final String id;
  final String name;
  final DateTime jobStartDate;
  final String jobPositionStructureId;

  const HistoricalJobPositionEntity({
    required this.id,
    required this.name,
    required this.jobStartDate,
    required this.jobPositionStructureId,
  });

  @override
  List<Object> get props => [
        id,
        name,
        jobStartDate,
        jobPositionStructureId,
      ];
}
