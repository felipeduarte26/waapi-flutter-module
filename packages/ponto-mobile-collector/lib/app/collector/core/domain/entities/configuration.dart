import 'package:equatable/equatable.dart';
import '../enums/insight_out_of_bound_type.dart';
import '../enums/operation_mode_type.dart';
import 'clocking_event_use.dart';

class Configuration extends Equatable {
  final String? id;
  final bool onlyOnline;
  final OperationModeType operationMode;
  final String timezone;
  final bool takePhoto;
  final bool? allowChangeTime;
  final bool? faceRecognition;
  final bool? faceRecognitionSingle;
  final bool? faceRecognitionMulti;
  final String? username;
  final bool? isManager;
  final String? managerId;
  final bool? overnight;
  final bool? controlOvernight;
  final List<ClockingEventUse>? clockingEventUses;
  final bool? gps;
  final bool? deviceAuthorizationType;
  final bool? allowDrivingTime;
  final bool? allowGpoOnApp;
  final bool? exportNotChecked;
  final InsightOutOfBoundType? insightOutOfBound;
  final bool? openExternalBrowser;
  final bool? allowUse;
  final bool? externalControlTimezone;
  final bool? nfcMode;
  final bool? takePhotoNfc;
  final bool? takePhotoSingle;
  final bool? takePhotoDriver;
  final bool? takePhotoQrcode;

  const Configuration({
    this.id,
    required this.onlyOnline,
    required this.operationMode,
    required this.timezone,
    required this.takePhoto,
    this.allowChangeTime,
    this.faceRecognition,
    this.faceRecognitionSingle,
    this.faceRecognitionMulti,
    this.username,
    this.isManager,
    this.managerId,
    this.overnight,
    this.controlOvernight,
    this.clockingEventUses,
    this.gps,
    this.deviceAuthorizationType,
    this.allowDrivingTime,
    this.allowGpoOnApp,
    this.exportNotChecked,
    this.insightOutOfBound,
    this.openExternalBrowser,
    this.allowUse,
    this.externalControlTimezone,
    this.nfcMode,
    this.takePhotoNfc,
    this.takePhotoSingle,
    this.takePhotoDriver,
    this.takePhotoQrcode,
  });

  Configuration copyWith({
    String? id,
    bool? onlyOnline,
    OperationModeType? operationMode,
    String? timezone,
    bool? takePhoto,
    bool? allowChangeTime,
    bool? faceRecognition,
    bool? faceRecognitionSingle,
    bool? faceRecognitionMulti,
    String? username,
    bool? isManager,
    String? managerId,
    bool? overnight,
    bool? controlOvernight,
    List<ClockingEventUse>? clockingEventUses,
    bool? gps,
    bool? deviceAuthorizationType,
    bool? allowDrivingTime,
    bool? allowGpoOnApp,
    bool? exportNotChecked,
    InsightOutOfBoundType? insightOutOfBound,
    bool? openExternalBrowser,
    bool? allowUse,
    bool? externalControlTimezone,
    bool? nfcMode,
    bool? takePhotoNfc,
    bool? takePhotoSingle,
    bool? takePhotoDriver,
    bool? takePhotoQrcode,
  }) {
    return Configuration(
      id: id ?? this.id,
      onlyOnline: onlyOnline ?? this.onlyOnline,
      operationMode: operationMode ?? this.operationMode,
      timezone: timezone ?? this.timezone,
      takePhoto: takePhoto ?? this.takePhoto,
      allowChangeTime: allowChangeTime ?? this.allowChangeTime,
      faceRecognition: faceRecognition ?? this.faceRecognition,
      faceRecognitionSingle: faceRecognitionSingle ?? this.faceRecognitionSingle,
      faceRecognitionMulti: faceRecognitionMulti ?? this.faceRecognitionMulti,
      username: username ?? this.username,
      isManager: isManager ?? this.isManager,
      managerId: managerId ?? this.managerId,
      overnight: overnight ?? this.overnight,
      controlOvernight: controlOvernight ?? this.controlOvernight,
      clockingEventUses: clockingEventUses ?? this.clockingEventUses,
      gps: gps ?? this.gps,
      deviceAuthorizationType: deviceAuthorizationType ?? this.deviceAuthorizationType,
      allowDrivingTime: allowDrivingTime ?? this.allowDrivingTime,
      allowGpoOnApp: allowGpoOnApp ?? this.allowGpoOnApp,
      exportNotChecked: exportNotChecked ?? this.exportNotChecked,
      insightOutOfBound: insightOutOfBound ?? this.insightOutOfBound,
      openExternalBrowser: openExternalBrowser ?? this.openExternalBrowser,
      allowUse: allowUse ?? this.allowUse,
      externalControlTimezone: externalControlTimezone ?? this.externalControlTimezone,
      nfcMode: nfcMode ?? this.nfcMode,
      takePhotoNfc: takePhotoNfc ?? this.takePhotoNfc,
      takePhotoSingle: takePhotoSingle ?? this.takePhotoSingle,
      takePhotoDriver: takePhotoDriver ?? this.takePhotoDriver,
      takePhotoQrcode: takePhotoQrcode ?? this.takePhotoQrcode,
    );
  }

  @override
  List<Object?> get props => [
        id,
        onlyOnline,
        operationMode,
        timezone,
        takePhoto,
        allowChangeTime,
        faceRecognition,
        faceRecognitionSingle,
        faceRecognitionMulti,
        username,
        isManager,
        managerId,
        overnight,
        controlOvernight,
        clockingEventUses,
        gps,
        deviceAuthorizationType,
        allowDrivingTime,
        allowGpoOnApp,
        exportNotChecked,
        insightOutOfBound,
        openExternalBrowser,
        allowUse,
        externalControlTimezone,
        nfcMode,
        takePhotoNfc,
        takePhotoSingle,
        takePhotoDriver,
        takePhotoQrcode,
      ];
}
