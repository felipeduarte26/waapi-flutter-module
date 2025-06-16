class StateLocationEntity {
  final bool isMock;
  final bool hasPermission;
  final bool isServiceEnabled;
  final bool success;
  final double? latitude;
  final double? longitude;

  StateLocationEntity({
    required this.hasPermission,
    required this.isServiceEnabled,
    required this.success,
    this.latitude,
    this.longitude,
    required this.isMock,
  });
}
