import 'package:equatable/equatable.dart';

class HistoricalJobPositionModel extends Equatable {
  final String id;
  final String name;
  final DateTime jobStartDate;
  final String jobPositionStructureId;

  const HistoricalJobPositionModel({
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
