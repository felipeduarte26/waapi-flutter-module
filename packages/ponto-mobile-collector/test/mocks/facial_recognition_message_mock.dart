import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';

FacialRecognitionMessage facialRecognitionMessageMock =
    const FacialRecognitionMessage(
  code: 95,
  status: 'status',
  message: 'message',
  detectionIssues: {'message': 'message'},
  auditId: 'auditId',
  method: 'method',
);

FacialRecognitionMessage facialRecognitionMessageNotAuthenticatedMock =
    const FacialRecognitionMessage(
  code: 96,
  status: 'status',
  message: 'message',
  detectionIssues: {'message': 'message'},
  auditId: 'auditId',
  method: 'method',
);

FacialRecognitionMessage facialRecognitionMessageIAErrorMock =
    const FacialRecognitionMessage(
  code: 91,
  status: 'status',
  message: 'message',
  detectionIssues: {'message': 'message'},
  auditId: 'auditId',
  method: 'method',
);

FacialRecognitionMessage facialRecognitionMessageUnknownMock =
    const FacialRecognitionMessage(
  code: 0,
  status: 'status',
  message: 'message',
  detectionIssues: {'message': 'message'},
  auditId: 'auditId',
  method: 'method',
);

const FacialRecognitionMessage facialSuccessRecognitionMessageMock =
    FacialRecognitionMessage(
  code: 90,
  status: 'success',
  message: 'message',
  detectionIssues: {'message': 'value'},
  auditId: 'auditId',
  method: 'method',
  externalIds: ['id'],
);

const FacialRecognitionMessage facialFailureRecognitionMessageMock =
    FacialRecognitionMessage(
  code: 93,
  status: 'failure',
  message: 'message',
  detectionIssues: {'message': 'value'},
  auditId: 'auditId',
  method: 'method',
);

const FacialRecognitionMessage facialNoMessageRecognitionMessageMock =
    FacialRecognitionMessage(
  code: 93,
  status: 'failure',
  message: 'message',
  detectionIssues: null,
  auditId: 'auditId',
  method: 'method',
);
