import 'package:equatable/equatable.dart';

abstract class AttachmentState extends Equatable {
  @override
  List<Object?> get props {
    return [];
  }
}

class InitialAttachmentState extends AttachmentState {}

class LoadingAttachmentState extends AttachmentState {}

class ErrorNativePermissionStorageState extends AttachmentState {}

class ErrorAttachmentsState extends AttachmentState {
  final String? errorMessage;

  ErrorAttachmentsState({
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      errorMessage,
    ];
  }
}

class LoadedAttachmentsState extends AttachmentState {
  final List<int> fileBytes;
  final String fileName;

  LoadedAttachmentsState({
    required this.fileBytes,
    required this.fileName,
  });

  @override
  List<Object?> get props {
    return [
      ...super.props,
      fileBytes,
      fileName,
    ];
  }
}

class ShareFileInitialState extends AttachmentState {}

class ErrorShareDetailsReceivedState extends AttachmentState {}

class ShareStringInitialState extends AttachmentState {}

class ErrorShareStringState extends AttachmentState {}
