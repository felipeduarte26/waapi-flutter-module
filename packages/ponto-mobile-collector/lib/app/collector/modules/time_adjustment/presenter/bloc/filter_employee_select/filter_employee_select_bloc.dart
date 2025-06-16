import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../facial_recognition/domain/entities/employee_item_entity.dart';
import '../../../../facial_recognition/domain/entities/pagination_employee_item_entity.dart';
import '../../../domain/usecases/get_employees_to_completed_appointments_usecase.dart';
import 'filter_employee_select_event.dart';
import 'filter_employee_select_state.dart';

class FilterEmployeeSelectBloc
    extends Bloc<FilterEmployeeSelectEvent, FilterEmployeeSelectState> {
  final GetEmployeesToCompletedAppointmentsUsecase
      _getCompletedAppointmentsUsecase;

  String? _nameSearch;
  String? username;
  List<EmployeeItemEntity> employees = [];
  List<String> employeesSelected = [];
  PaginationEmployeeItemEntity? paginationEmployees;

  FilterEmployeeSelectBloc({
    required GetEmployeesToCompletedAppointmentsUsecase
        getCompletedAppointmentsUsecase,
  })  : _getCompletedAppointmentsUsecase = getCompletedAppointmentsUsecase,
        super(FilterEmployeeSearchInitial()) {
    on<FilterEmployeeInitEvent>(init);
    on<FilterEmployeeLoadMoreEvent>(loadMore);
    on<FilterEmployeeSelectEmployeeEvent>(selectEmployee);
    on<FilterEmployeeClearSelectionEvent>(clear);
    on<FilterEmployeeClearInputEvent>(cleanSearch);
    on<FilterEmployeeSearchEvent>(doSearch);
  }

  void changeNameSearch(String? name) async {
    _nameSearch = name;
  }

  String? getNameSearch() {
    return _nameSearch;
  }

  Future<void> init(event, emit) async {
    if (username == null) {
      emit(FilterEmployeeSearchFailure());
    }
    emit(FilterEmployeeSearchInProgress());
    var filterEmployeeSelectState = await search();
    emit(filterEmployeeSelectState);
  }

  Future<void> doSearch(event, emit) async {
    emit(FilterEmployeeSearchInProgress());
    var filterEmployeeSelectState = await search();
    emit(filterEmployeeSelectState);
  }

  Future<FilterEmployeeSelectState> search({int pageNumber = 0}) async {
    try {
      paginationEmployees = await _getCompletedAppointmentsUsecase.call(
        nameEmployee: _nameSearch,
        pageNumber: pageNumber,
        username: username!,
      );

      employees =
          paginationEmployees != null ? paginationEmployees!.employees : [];

      return FilterReadyContent();
    } catch (e) {
      return FilterEmployeeSearchFailure();
    }
  }

  Future<void> loadMore(event, emit) async {
    try {
      emit(FilterEmployeeSearchLoadMoreInProgress());

      var pageNumber =
          paginationEmployees != null ? paginationEmployees!.pageNumber + 1 : 0;
      paginationEmployees = await _getCompletedAppointmentsUsecase.call(
        nameEmployee: _nameSearch,
        pageNumber: pageNumber,
        username: username!,
      );
      employees.addAll(paginationEmployees!.employees);
      emit(FilterReadyContent());
    } catch (e) {
      emit(FilterEmployeeSearchFailure());
    }
  }

  void selectEmployee(event, emit) {
    employeesSelected.contains(event.employeeId)
        ? employeesSelected.remove(event.employeeId)
        : employeesSelected.add(event.employeeId);
    emit(FilterEmployeeSelected());
  }

  void clear(event, emit) {
    employeesSelected = [];
    emit(FilterReadyContent());
  }

  void cleanSearch(event, emit) async {
    _nameSearch = null;
    var toEmit = await search();
    emit(toEmit);
  }
}
