import 'package:equatable/equatable.dart';

class SocialRequestFileUploadInputModel extends Equatable {
  final String id;
  final String filePath;
  final String fileName;
  final int fileSize;
  final String fileType;
  final List<int> fileBytes;

  const SocialRequestFileUploadInputModel({
    required this.id,
    required this.fileSize,
    required this.fileName,
    required this.fileType,
    required this.fileBytes,
    required this.filePath,
  });

  @override
  List<Object?> get props => [
        id,
        fileSize,
        fileName,
        fileType,
        fileBytes,
        filePath,
      ];
}
