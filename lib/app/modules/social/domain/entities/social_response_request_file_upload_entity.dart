import 'package:equatable/equatable.dart';

class SocialResponseRequestFileUploadEntity extends Equatable {
  final String url;
  final String version;
  final String fileName;
  final String id;

  const SocialResponseRequestFileUploadEntity({
    required this.url,
    required this.version,
    required this.fileName,
    required this.id,
  });

  @override
  List<Object> get props => [
        url,
        version,
        fileName,
        id,
      ];
}
