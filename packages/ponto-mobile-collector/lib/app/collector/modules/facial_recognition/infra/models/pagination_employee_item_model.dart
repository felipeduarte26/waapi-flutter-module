import 'package:equatable/equatable.dart';

import 'employee_item_model.dart';

class PaginationEmployeeItemModel extends Equatable {
  final int pageNumber;
  final int pageSize;
  final int totalPage;
  final List<EmployeeItemModel> employees;

  const PaginationEmployeeItemModel({
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
