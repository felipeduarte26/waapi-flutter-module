class JourneyEntity {
  final String id;
  final int? _journeyNumber;
  final String employeeId;
  final DateTime startDate;
  final DateTime? endDate;
  final String? overnightId;

  JourneyEntity({
    required this.id,
    int? journeyNumber,
    required this.employeeId,
    required this.startDate,
    this.endDate,
    this.overnightId,
  }) : _journeyNumber = journeyNumber;

  int get journeyNumber => _journeyNumber ?? 0;

  JourneyEntity copyWith({
    String? id,
    int? journeyNumber,
    String? employeeId,
    DateTime? startDate,
    DateTime? endDate,
    String? overnightId,
  }) {
    return JourneyEntity(
      id: id ?? this.id,
      journeyNumber: journeyNumber ?? this.journeyNumber,
      employeeId: employeeId ?? this.employeeId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      overnightId: overnightId ?? this.overnightId,
    );
  }
}
