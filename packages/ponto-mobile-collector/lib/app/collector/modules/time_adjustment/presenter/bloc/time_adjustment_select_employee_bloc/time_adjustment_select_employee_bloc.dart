import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../facial_recognition/domain/entities/employee_item_entity.dart';
import '../../../../facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import '../../../domain/usecases/get_employees_to_completed_appointments_usecase.dart';
import 'time_adjustment_select_employee_event.dart';
import 'time_adjustment_select_employee_state.dart';

class TimeAdjustmentSelectEmployeeBloc extends Bloc<
    TimeAdjustmentSelectEmployeeEvent, TimeAdjustmentSelectEmployeeState> {
  final GetEmployeesToCompletedAppointmentsUsecase
      _getCompletedAppointmentsUsecase;

  String? username;
  String? _nameSearch;
  List<EmployeeItemEntity> employees = [];
  String? selectedEmployee;
  PaginationEmployeeItemEntity? paginationEmployees;

  TimeAdjustmentSelectEmployeeBloc({
    required GetEmployeesToCompletedAppointmentsUsecase
        getCompletedAppointmentsUsecase,
  })  : _getCompletedAppointmentsUsecase = getCompletedAppointmentsUsecase,
        super(MultipleEmployeeSearchInitial()) {
    on<TimeAdjustmentSelectEmployeeSearch>(searchForEmployee);
    on<TimeAdjustmentSelectEmployeeSearching>(changeNameSearch);
    on<TimeAdjustmentSelectEmployeeSearchClean>(cleanSearch);
    on<TimeAdjustmentSelectEmployeeLoadMore>(loadMore);
    on<TimeAdjustmentSelectedEmployee>(selectEmployee);
  }

  void searchForEmployee(event, emit) async {
    emit(MultipleEmployeeSearchInProgress());
    var toEmit = await search();
    emit(toEmit);
  }

  void changeNameSearch(event, emit) async {
    _nameSearch = event.employeeNameSearch;
  }

  String? getNameSearch() {
    return _nameSearch;
  }

  Future<TimeAdjustmentSelectEmployeeState> search() async {
    if (username != null) {
      paginationEmployees = await _getCompletedAppointmentsUsecase.call(
        nameEmployee: _nameSearch,
        username: username!,
      );

      employees =
          paginationEmployees != null ? paginationEmployees!.employees : [];

      return MultipleReadyContent();
    }

    return MultipleEmployeeSearchFailure();
  }

  void loadMore(event, emit) async {
    try {
      if (username != null) {
        emit(MultipleEmployeeSearchLoadMoreInProgress());
        var pageNumber = paginationEmployees != null
            ? paginationEmployees!.pageNumber + 1
            : 0;
        paginationEmployees = await _getCompletedAppointmentsUsecase.call(
          nameEmployee: _nameSearch,
          pageNumber: pageNumber,
          username: username ?? '',
        );
        employees.addAll(paginationEmployees!.employees);
      }
      emit(MultipleReadyContent());
    } catch (e) {
      emit(MultipleEmployeeSearchFailure());
    }
  }

  void selectEmployee(event, emit) {
    selectedEmployee = event.employeeId;
    emit(MultipleEmployeeSelected());
  }

  void cleanSearch(event, emit) async {
    _nameSearch = null;
    var timeAdjustmentSelectEmployeeState = await search();
    emit(timeAdjustmentSelectEmployeeState);
  }
}
