import 'package:equatable/equatable.dart';

class PlatformAuthorizationModel extends Equatable {
  final String resource;
  final String action;
  final bool authorized;

  const PlatformAuthorizationModel({
    required this.resource,
    required this.action,
    required this.authorized,
  });

  @override
  List<Object> get props {
    return [
      resource,
      action,
      authorized,
    ];
  }
}
