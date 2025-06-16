import 'package:equatable/equatable.dart';

class PaginationEntity extends Equatable {
  final int pageNumber;
  final int pageSize;
  final int totalPage;
  final List<Object> objects;

  const PaginationEntity({
    required this.pageNumber,
    required this.pageSize,
    required this.totalPage,
    required this.objects,
  });

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        totalPage,
        objects,
      ];
}
