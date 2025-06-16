class CrashLog {
  String id;
  String createdAt;
  String deviceId;
  String? userPlatform;
  String? employeeId;
  String? employeeExternalId;
  String log;

  CrashLog({
    required this.id,
    required this.createdAt,
    required this.deviceId,
    this.userPlatform,
    required this.log,
    this.employeeExternalId,
    this.employeeId,
  });

  factory CrashLog.fromJson(Map<String, dynamic> json) {
    return CrashLog(
      id: json['id'],
      createdAt: json['dateAndTime'],
      deviceId: json['deviceId'],
      userPlatform: json['userPlatform'],
      log: json['log'],
      employeeExternalId: json['employeeExternalId'],
      employeeId: json['employeeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateAndTime': createdAt,
      'deviceId': deviceId,
      'userPlatform': userPlatform,
      'log': log,
      'employeeExternalId': employeeExternalId,
      'employeeId': employeeId,
    };
  }
}
