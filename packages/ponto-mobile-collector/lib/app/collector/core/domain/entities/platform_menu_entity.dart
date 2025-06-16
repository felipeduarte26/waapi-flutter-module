import 'package:equatable/equatable.dart';

class PlatformMenuEntity extends Equatable {
  final String id;
  final String name;
  final String resource;
  final String permission;
  final String description;
  final String url;
  final String backendUrl;
  final bool active;
  final String flutterIcon;

  const PlatformMenuEntity({
    required this.id,
    required this.name,
    required this.resource,
    required this.permission,
    required this.description,
    required this.url,
    required this.backendUrl,
    required this.active,
    required this.flutterIcon,
  });

  @override
  List<Object?> get props => [
        id,
      ];
}
