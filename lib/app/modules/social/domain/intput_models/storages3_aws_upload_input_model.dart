import 'package:equatable/equatable.dart';

class Storages3AwsUploadInputModel extends Equatable {
  final String url;
  final String version;
  final String fileName;
  final String id;

  const Storages3AwsUploadInputModel({
    required this.url,
    required this.version,
    required this.fileName,
    required this.id,
  });

  @override
  List<Object?> get props => [
        url,
        version,
        fileName,
        id,
      ];
}
