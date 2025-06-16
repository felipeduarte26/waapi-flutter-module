import 'package:equatable/equatable.dart';

abstract class NeedAttachmentEditState extends Equatable {
  const NeedAttachmentEditState();

  @override
  List<Object> get props {
    return [];
  }
}

class InitialNeedAttachmentEditState extends NeedAttachmentEditState {}

class LoadingNeedAttachmentEditState extends NeedAttachmentEditState {}

class LoadedNeedAttachmentEditState extends NeedAttachmentEditState {
  final bool needAttachmentEdit;

  const LoadedNeedAttachmentEditState({
    required this.needAttachmentEdit,
  });
}

class ErrorNeedAttachmentEditState extends NeedAttachmentEditState {}
