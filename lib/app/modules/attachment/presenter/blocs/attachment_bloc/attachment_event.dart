import 'package:equatable/equatable.dart';

import '../../../domain/entities/attachment_entity.dart';

abstract class AttachmentEvent extends Equatable {}

class DownloadAttachmentEvent extends AttachmentEvent {
  final AttachmentEntity attachmentEntity;

  DownloadAttachmentEvent({
    required this.attachmentEntity,
  });

  @override
  List<Object?> get props {
    return [
      attachmentEntity,
    ];
  }
}

class ShareAttachmentEvent extends AttachmentEvent {
  final String file;

  ShareAttachmentEvent({
    required this.file,
  });

  @override
  List<Object?> get props {
    return [
      file,
    ];
  }
}

class ShareFileReceivedEvent extends AttachmentEvent {
  final String fileToShare;

  ShareFileReceivedEvent({
    required this.fileToShare,
  });

  @override
  List<Object?> get props {
    return [
      fileToShare,
    ];
  }
}

class ShareStringEvent extends AttachmentEvent {
  final String stringToShare;

  ShareStringEvent({
    required this.stringToShare,
  });

  @override
  List<Object?> get props {
    return [
      stringToShare,
    ];
  }
}
