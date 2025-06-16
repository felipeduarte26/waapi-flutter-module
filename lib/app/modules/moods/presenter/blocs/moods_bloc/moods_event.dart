import 'package:equatable/equatable.dart';

abstract class MoodsEvent extends Equatable {}

class GetMoodsEvent extends MoodsEvent {
  final String userId;

  GetMoodsEvent({
    required this.userId,
  });

  @override
  List<Object> get props {
    return [
      userId,
    ];
  }
}
