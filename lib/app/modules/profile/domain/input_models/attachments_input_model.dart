import 'package:equatable/equatable.dart';

class AttachmentsInputModel extends Equatable {
  final String id;
  final String name;
  final String link;
  final String personId;
  final String operation;

  const AttachmentsInputModel({
    required this.id,
    required this.name,
    required this.link,
    required this.personId,
    required this.operation,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        link,
        personId,
        operation,
      ];
}
