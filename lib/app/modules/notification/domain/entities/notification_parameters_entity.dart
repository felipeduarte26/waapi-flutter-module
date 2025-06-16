import 'package:equatable/equatable.dart';

class NotificationParametersEntity extends Equatable {
  final String id;

  const NotificationParametersEntity({
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }
}
