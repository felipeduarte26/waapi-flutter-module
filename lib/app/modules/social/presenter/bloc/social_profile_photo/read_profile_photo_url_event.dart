import 'package:equatable/equatable.dart';

abstract class ReadProfilePhotoURLEvent extends Equatable {}

class GetReadProfilePhotoURLEvent extends ReadProfilePhotoURLEvent {
  final String userId;

  GetReadProfilePhotoURLEvent({
    required this.userId,
  });

  @override
  List<Object> get props {
    return [
      userId,
    ];
  }
}
