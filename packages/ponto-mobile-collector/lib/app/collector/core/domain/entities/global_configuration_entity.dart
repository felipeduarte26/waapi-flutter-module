class GlobalConfigurationEntity {
  final String id;
  final bool? gps;
  final bool? online;
  final String? timeout;
  final String? operationMode;
  final bool? nfcMode;
  final bool? allowChangeTime;
  final String? timezone;
  final String? deviceAuthModeSingleMode;
  final String? deviceAuthModeMultiMode;
  final String? deviceAuthModeDriverMode;
  final bool? allowDrivingTime;
  final bool? overnight;
  final bool? controlOvernight;
  final bool? allowGpoOnApp;
  final bool? exportNotChecked;
  final String? insightOutOfBound;
  final bool? takePhotoSingle;
  final bool? takePhotoMulti;
  final bool? takePhotoDriver;
  final bool? takePhotoQrcode;
  final bool? takePhotoNfc;
  final bool? openExternalBrowser;
  final List<String>? clockingEventUses;
  final bool? allowUse;
  final bool? externalControlTimezone;
  final bool? faceRecognition;

  const GlobalConfigurationEntity({
    required this.id,
    this.gps,
    this.online,
    this.timeout,
    this.operationMode,
    this.nfcMode,
    this.allowChangeTime,
    this.timezone,
    this.deviceAuthModeSingleMode,
    this.deviceAuthModeMultiMode,
    this.deviceAuthModeDriverMode,
    this.allowDrivingTime,
    this.overnight,
    this.controlOvernight,
    this.allowGpoOnApp,
    this.exportNotChecked,
    this.insightOutOfBound,
    this.takePhotoSingle,
    this.takePhotoMulti,
    this.takePhotoDriver,
    this.takePhotoQrcode,
    this.takePhotoNfc,
    this.openExternalBrowser,
    this.clockingEventUses,
    this.allowUse,
    this.externalControlTimezone,
    this.faceRecognition,
  });

  factory GlobalConfigurationEntity.fromMap(Map<String, dynamic> map) {
    return GlobalConfigurationEntity(
      id: map['id'],
      gps: map['gps'],
      online: map['online'],
      timeout: map['timeout'],
      operationMode: map['operationMode'],
      nfcMode: map['nfcMode'],
      allowChangeTime: map['allowChangeTime'],
      timezone: map['timezone'],
      deviceAuthModeSingleMode: map['deviceAuthModeSingleMode'],
      deviceAuthModeMultiMode: map['deviceAuthModeMultiMode'],
      deviceAuthModeDriverMode: map['deviceAuthModeDriverMode'],
      allowDrivingTime: map['allowDrivingTime'],
      overnight: map['overnight'],
      controlOvernight: map['controlOvernight'],
      allowGpoOnApp: map['allowGpoOnApp'],
      exportNotChecked: map['exportNotChecked'],
      insightOutOfBound: map['insightOutOfBound'],
      takePhotoSingle: map['takePhotoSingle'],
      takePhotoMulti: map['takePhotoMulti'],
      takePhotoDriver: map['takePhotoDriver'],
      takePhotoQrcode: map['takePhotoQrcode'],
      takePhotoNfc: map['takePhotoNfc'],
      openExternalBrowser: map['openExternalBrowser'],
      clockingEventUses: List<String>.from(map['clockingEventUses']),
      allowUse: map['allowUse'],
      externalControlTimezone: map['externalControlTimezone'],
      faceRecognition: map['faceRecognition'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gps': gps,
      'online': online,
      'timeout': timeout,
      'operationMode': operationMode,
      'nfcMode': nfcMode,
      'allowChangeTime': allowChangeTime,
      'timezone': timezone,
      'deviceAuthModeSingleMode': deviceAuthModeSingleMode,
      'deviceAuthModeMultiMode': deviceAuthModeMultiMode,
      'deviceAuthModeDriverMode': deviceAuthModeDriverMode,
      'allowDrivingTime': allowDrivingTime,
      'overnight': overnight,
      'controlOvernight': controlOvernight,
      'allowGpoOnApp': allowGpoOnApp,
      'exportNotChecked': exportNotChecked,
      'insightOutOfBound': insightOutOfBound,
      'takePhotoSingle': takePhotoSingle,
      'takePhotoMulti': takePhotoMulti,
      'takePhotoDriver': takePhotoDriver,
      'takePhotoQrcode': takePhotoQrcode,
      'takePhotoNfc': takePhotoNfc,
      'openExternalBrowser': openExternalBrowser,
      'clockingEventUses': clockingEventUses,
      'allowUse': allowUse,
      'externalControlTimezone': externalControlTimezone,
      'faceRecognition': faceRecognition,
    };
  }

}
