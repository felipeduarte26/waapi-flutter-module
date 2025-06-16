class FacialRecognitionMessage {
  final int code;
  final String status;
  final String? message;
  final dynamic detectionIssues;
  final dynamic auditId;
  final String? method;
  final Object? externalIds;
  final String? camera;

  const FacialRecognitionMessage({
    required this.code,
    required this.status,
    this.message,
    this.method,
    this.detectionIssues,
    this.auditId,
    this.camera,
    this.externalIds,
  });

  factory FacialRecognitionMessage.fromMap(Map<dynamic, dynamic> map) {
    FacialRecognitionMessage message = FacialRecognitionMessage(
      code: map['code'],
      status: map['status'],
      message: map['message'],
      detectionIssues: map['detectionIssues'],
      auditId: map['audit_id'],
      method: map['method'],
      camera: map['camera'],
      externalIds: map['external_ids'],
    );

    return message;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'code': code,
      'status': status,
      'message': message,
      'detectionIssues': detectionIssues,
      'audit_id': auditId,
      'method': method,
      'camera': camera,
      'external_ids': externalIds,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FacialRecognitionMessage &&
        other.code == code &&
        other.status == status &&
        other.message == message &&
        other.detectionIssues == detectionIssues &&
        other.auditId == auditId &&
        other.camera == camera &&
        other.externalIds == externalIds;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        status.hashCode ^
        message.hashCode ^
        detectionIssues.hashCode ^
        auditId.hashCode ^
        camera.hashCode ^
        externalIds.hashCode;
  }

  @override
  String toString() {
    return 'Code: $code, Status: $status, Message: $message, detectionIssues: $detectionIssues, AuditId: $auditId, Camera: $camera';
  }
}
