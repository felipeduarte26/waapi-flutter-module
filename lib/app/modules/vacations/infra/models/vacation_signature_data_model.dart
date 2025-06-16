import 'package:equatable/equatable.dart';

import '../../enums/vacation_document_status_enum.dart';
import '../../enums/vacation_document_type_enum.dart';

class VacationSignatureDataModel extends Equatable {
  final String gedSignatureLink;
  final String signedDocumentUrl;
  final VacationDocumentTypeEnum documentType;
  final VacationDocumentStatusEnum status;

  const VacationSignatureDataModel({
    required this.gedSignatureLink,
    required this.signedDocumentUrl,
    required this.documentType,
    required this.status,
  });

  @override
  List<Object?> get props => [
        gedSignatureLink,
        signedDocumentUrl,
        documentType,
        status,
      ];
}
