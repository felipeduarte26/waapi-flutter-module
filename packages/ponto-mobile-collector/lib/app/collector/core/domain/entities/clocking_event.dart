import '../enums/location_status.dart';
import '../input_model/location_dto.dart';
import 'device.dart';

class ClockingEvent  {
  final String id;
  final String dateEvent;
  final String timeEvent;
  final String timeZone;
  final String cpf;
  final String employeeName;
  final String employeeId;
  final String companyName;
  final String companyIdentifier;
  final String signature;
  final String use;
  final String? journeyEventName;
  final bool isMealBreak;
  final LocationDto? location;
  final LocationStatusEnum? locationStatus;
  final String? appVersion;
  final String? platform;
  final Device? device;
  final String? facialRecognitionStatus;
  final String? fenceState;
  final int signatureVersion;
  final String? appointmentImage;
  final String? photoNotCaptured;
  final String? mode;
  final String? origin;
  final bool? online;
  final String? clientOriginInfo;
  late bool isSynchronized;

  ClockingEvent({
    required this.id,
    required this.dateEvent,
    required this.timeEvent,
    required this.timeZone,
    required this.cpf,
    required this.employeeName,
    required this.employeeId,
    required this.companyName,
    required this.companyIdentifier,
    required this.signature,
    required this.use,
    this.journeyEventName,
    this.isMealBreak = false,
    this.location,
    this.locationStatus,
    this.appVersion,
    this.platform,
    this.device,
    this.facialRecognitionStatus,
    this.fenceState,
    required this.signatureVersion,
    this.appointmentImage,
    this.photoNotCaptured,
    this.mode,
    this.origin,
    this.online,
    this.clientOriginInfo,
    this.isSynchronized = false,
  });

  DateTime getDateTimeEvent() {
    return DateTime.parse('$dateEvent ${timeEvent}Z');
  }

  ClockingEvent copyWith({
    String? id,
    String? dateEvent,
    String? timeEvent,
    String? timeZone,
    String? cpf,
    String? employeeName,
    String? employeeId,
    String? companyName,
    String? companyIdentifier,
    String? signature,
    String? use,
    String? journeyEventName,
    bool? isMealBreak,
    LocationDto? location,
    LocationStatusEnum? locationStatus,
    String? appVersion,
    String? platform,
    Device? device,
    String? facialRecognitionStatus,
    String? fenceState,
    int? signatureVersion,
    String? appointmentImage,
    String? photoNotCaptured,
    String? mode,
    String? origin,
    bool? online,
    String? clientOriginInfo,
    bool? isSynchronized,
  }) {
    return ClockingEvent(
      id: id ?? this.id,
      dateEvent: dateEvent ?? this.dateEvent,
      timeEvent: timeEvent ?? this.timeEvent,
      timeZone: timeZone ?? this.timeZone,
      cpf: cpf ?? this.cpf,
      employeeName: employeeName ?? this.employeeName,
      employeeId: employeeId ?? this.employeeId,
      companyName: companyName ?? this.companyName,
      companyIdentifier: companyIdentifier ?? this.companyIdentifier,
      signature: signature ?? this.signature,
      use: use ?? this.use,
      journeyEventName: journeyEventName ?? this.journeyEventName,
      isMealBreak: isMealBreak ?? this.isMealBreak,
      location: location ?? this.location,
      locationStatus: locationStatus ?? this.locationStatus,
      appVersion: appVersion ?? this.appVersion,
      platform: platform ?? this.platform,
      device: device ?? this.device,
      facialRecognitionStatus: facialRecognitionStatus ?? this.facialRecognitionStatus,
      fenceState: fenceState ?? this.fenceState,
      signatureVersion: signatureVersion ?? this.signatureVersion,
      appointmentImage: appointmentImage ?? this.appointmentImage,
      photoNotCaptured: photoNotCaptured ?? this.photoNotCaptured,
      mode: mode ?? this.mode,
      origin: origin ?? this.origin,
      online: online ?? this.online,
      clientOriginInfo: clientOriginInfo ?? this.clientOriginInfo,
      isSynchronized: isSynchronized ?? this.isSynchronized,
    );
  }

  List<Object?> get props => [
        id,
        dateEvent,
        timeEvent,
        timeZone,
        cpf,
        employeeName,
        employeeId,
        companyName,
        companyIdentifier,
        signature,
        use,
        journeyEventName,
        isMealBreak,
        location,
        locationStatus,
        appVersion,
        platform,
        device,
        facialRecognitionStatus,
        fenceState,
        signatureVersion,
        appointmentImage,
        photoNotCaptured,
        mode,
        origin,
        online,
        clientOriginInfo,
        isSynchronized,
      ];
}
