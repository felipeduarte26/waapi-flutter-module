import 'package:equatable/equatable.dart';

abstract class NeedAttachmentEditEvent extends Equatable {
  const NeedAttachmentEditEvent();

  @override
  List<Object> get props {
    return [];
  }
}

class GetNeedAttachmentEditEvent extends NeedAttachmentEditEvent {
  final String role;

  const GetNeedAttachmentEditEvent({
    required this.role,
  });

  @override
  List<Object> get props {
    return [
      ...super.props,
      role,
    ];
  }
}
