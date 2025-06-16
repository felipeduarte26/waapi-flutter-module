import 'package:equatable/equatable.dart';

import 'employee_item_entity.dart';

class PaginationEmployeeItemEntity extends Equatable {
  final int pageNumber;
  final int pageSize;
  final int totalPage;
  final List<EmployeeItemEntity> employees;

  const PaginationEmployeeItemEntity({
    required this.pageNumber,
    required this.pageSize,
    required this.totalPage,
    required this.employees,
  });

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        totalPage,
        employees,
      ];
}
