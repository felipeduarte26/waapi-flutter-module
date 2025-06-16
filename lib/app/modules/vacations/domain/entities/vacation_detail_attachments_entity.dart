import 'package:equatable/equatable.dart';

class VacationDetailAttachmentsEntity extends Equatable {
  final String id;
  final String name;
  final String link;
  final String personId;
  final String sourceId;
  final String sourceType;

  const VacationDetailAttachmentsEntity({
    required this.id,
    required this.name,
    required this.link,
    required this.personId,
    required this.sourceId,
    required this.sourceType,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        link,
        personId,
        sourceId,
        sourceType,
      ];
}
