import 'package:equatable/equatable.dart';

abstract class URLPostEvent extends Equatable {}

class GetURLPostEvent extends URLPostEvent {
  final String postId;

  GetURLPostEvent({
    required this.postId,
  });

  @override
  List<Object> get props {
    return [
      postId,
    ];
  }
}
