class DeviceConfiguration {
  /// Device identifier
  String id;

  bool enableNfc;
  bool enableQrCode;
  bool enableFacial;
  bool enableUserPassword;
  bool allowChangeTime;
  String timeZone;
  DateTime lastUpdate;
  DateTime lastSync;

  DeviceConfiguration({
    required this.id,
    required this.enableNfc,
    required this.enableQrCode,
    required this.enableFacial,
    required this.timeZone,
    required this.lastUpdate,
    required this.lastSync,
    required this.enableUserPassword,
    required this.allowChangeTime,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeviceConfiguration &&
        other.id == id &&
        other.enableNfc == enableNfc &&
        other.enableQrCode == enableQrCode &&
        other.enableFacial == enableFacial &&
        other.enableUserPassword == enableUserPassword &&
        other.allowChangeTime == allowChangeTime &&
        other.timeZone == timeZone &&
        other.lastUpdate == lastUpdate &&
        other.lastSync == lastSync;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        enableNfc.hashCode ^
        enableQrCode.hashCode ^
        enableFacial.hashCode ^
        enableUserPassword.hashCode ^
        allowChangeTime.hashCode ^
        timeZone.hashCode ^
        lastUpdate.hashCode ^
        lastSync.hashCode;
  }

  DeviceConfiguration copyWith({
    String? id,
    bool? allowChangeTime,
    bool? enableFacial,
    bool? enableNfc,
    bool? enableQrCode,
    bool? enableUserPassword,
    DateTime? lastSync,
    DateTime? lastUpdate,
    String? timeZone,
  }) {
    return DeviceConfiguration(
      id: id ?? this.id,
      allowChangeTime: allowChangeTime ?? this.allowChangeTime,
      enableFacial: enableFacial ?? this.enableFacial,
      enableNfc: enableNfc ?? this.enableNfc,
      enableQrCode: enableQrCode ?? this.enableQrCode,
      enableUserPassword: enableUserPassword ?? this.enableUserPassword,
      lastSync: lastSync ?? this.lastSync,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      timeZone: timeZone ?? this.timeZone,
    );
  }
}
