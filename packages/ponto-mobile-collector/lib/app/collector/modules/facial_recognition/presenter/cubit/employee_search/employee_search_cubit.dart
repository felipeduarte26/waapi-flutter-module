import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/domain/entities/user_permission_check_entity.dart';
import '../../../../../core/domain/usecases/check_conection_usecase.dart';
import '../../../../../core/domain/usecases/check_user_permission_usecase.dart';
import '../../../../../core/infra/utils/enum/user_action_enum.dart';
import '../../../../../core/infra/utils/enum/user_resource_enum.dart';
import '../../../domain/entities/employee_item_entity.dart';
import '../../../domain/entities/pagination_employee_item_entity.dart';
import '../../../domain/usecases/get_employees_to_facial_registration_usecase.dart';
import 'employee_search_state.dart';

class EmployeeSearchCubit extends Cubit<EmployeeSearchState> {
  final GetEmployeesToFacialRegistrationUsecase
      getEmployeesToFacialRegistrationUsecase;
  final CheckUserPermissionUsecase checkUserPermissionUsecase;
  final IHasConnectivityUsecase hasConnectivityUsecase;

  String? _nameSearch;
  List<EmployeeItemEntity> employees = [];
  PaginationEmployeeItemEntity? paginationEmployees;

  EmployeeSearchCubit({
    required this.getEmployeesToFacialRegistrationUsecase,
    required this.checkUserPermissionUsecase,
    required this.hasConnectivityUsecase,
  }) : super(EmployeeSearchInitial()) {
    init();
  }

  void changeNameSearch(String? name) async {
    _nameSearch = name;
  }

  String? getNameSearch() {
    return _nameSearch;
  }

  Future<void> init() async {
    emit(EmployeeSearchInitial());
    if (!(await hasConnectivityUsecase.call())) {
      emit(EmployeeSearchOffline());
      return;
    }
    await checkUserPermissionUsecase.call(
      userPermissionCheckEntity: [
        UserPermissionCheckEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.facialAuth.resource,
        ),
      ],
    ).then(
      (value) {
        if (value.authorized) {
          search();
        } else {
          emit(EmployeeSearchNotPermission());
        }
      },
    ).catchError((onError) {
      emit(EmployeeSearchNotPermission());
    });
  }

  Future<void> search() async {
    try {
      emit(EmployeeSearchInProgress());
      paginationEmployees = await getEmployeesToFacialRegistrationUsecase.call(
        name: _nameSearch,
      );

      employees =
          paginationEmployees != null ? paginationEmployees!.employees : [];

      emit(EmployeeSearchSuccess());
    } catch (e) {
      emit(EmployeeSearchFailure());
    }
  }

  Future<void> loadMore() async {
    try {
      paginationEmployees = await getEmployeesToFacialRegistrationUsecase.call(
        name: _nameSearch,
        pageNumber: paginationEmployees!.pageNumber + 1,
      );
      emit(EmployeeSearchLoadMoreInProgress());
      employees.addAll(paginationEmployees!.employees);
      emit(EmployeeSearchSuccess());
    } catch (e) {
      emit(EmployeeSearchFailure());
    }
  }
}
