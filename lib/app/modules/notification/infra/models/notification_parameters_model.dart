import 'package:equatable/equatable.dart';

class NotificationParametersModel extends Equatable {
  final String id;

  const NotificationParametersModel({
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }
}
