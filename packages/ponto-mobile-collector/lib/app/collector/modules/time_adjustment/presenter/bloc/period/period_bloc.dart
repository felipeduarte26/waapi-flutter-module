import 'package:bloc/bloc.dart';
import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart' as clock;

import '../../../../../../../ponto_mobile_collector.dart';
import '../../../../../core/domain/entities/overnight_entity.dart';
import '../../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../../core/domain/input_model/employee_dto.dart';
import '../../../../../core/domain/usecases/find_employee_by_username_usecase.dart';
import '../../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../../../core/infra/utils/enum/ordering_mode_enum.dart';
import '../../../../clocking_event/domain/usecase/get_employee_usecase.dart';
import '../../../domain/usecases/get_clocking_event_by_manager_usecase.dart';
import '../../../domain/usecases/verify_user_logged_is_admin_usecase.dart';
import '../../../domain/usecases/verify_user_logged_is_manager_usecase.dart';

class PeriodBloc extends Bloc<PeriodEvent, PeriodState> {
  final clock.IInternalClockService _internalClockService;
  final IUtils _utils;
  final IClockingEventRepository _clockingEventRepository;
  final IGetEmployeeUsecase _getEmployeeUsecase;
  final IDayInfoService _dayInfoService;
  final IOvernightRepository _overnightRepository;
  final VerifyUserLoggedIsManagerUsecase _verifyUserLoggedIsManagerUsecase;
  final VerifyUserLoggedIsAdminUsecase _verifyUserLoggedIsAdminUsecase;
  final FindEmployeeIdByUsernameUsecase _findEmployeeIdByUsernameUsecase;
  final GetClockingEventByManagerUsecase _getClockingEventByManagerUsecase;
  final ClockingEventMapper _clockingEventMapper;

  String? username;

  DateTime requestDate = DateTime.now();

  String? error;

  /// Filter pra saber se está selecionado os botões.
  bool isPeriodSelected = false;

  bool isEmployeesSelected = false;

  /// Colaboradores selecionados no filtro.
  List<String>? employeesIds;

  /// Data selecionadas no filtro.
  DateTime initialDateFilter = DateTime.now();
  DateTime finalDateFilter = DateTime.now();

  /// Data da ultima atualização.
  DateTime requiresDate = DateTime.now();

  PeriodBloc(
    this._internalClockService,
    this._utils,
    this._clockingEventRepository,
    this._getEmployeeUsecase,
    this._dayInfoService,
    this._overnightRepository,
    this._verifyUserLoggedIsManagerUsecase,
    this._verifyUserLoggedIsAdminUsecase,
    this._findEmployeeIdByUsernameUsecase,
    this._getClockingEventByManagerUsecase,
    this._clockingEventMapper,
  ) : super(LoadingDayInfoState()) {
    on<LoadPeriodEvent>(
      (event, emit) async {
        emit(LoadingDayInfoState());

        if (isPeriodSelected) {
          var initialDate = initialDateFilter;
          var finalDate = finalDateFilter;

          emit(
            await _loadData(
              initDate: initialDate,
              endDate: finalDate,
              isPeriodSelected: isPeriodSelected,
              isEmployeesSelected: isEmployeesSelected,
              employeesIds: employeesIds,
            ),
          );
          return;
        }

        var periodState = await todayPeriod();
        emit(periodState);
      },
    );

    on<TodayPeriodEvent>(
      (event, emit) async {
        emit(LoadingDayInfoState());

        var periodState = await todayPeriod();

        emit(periodState);
      },
    );

    on<RefreshPeriodEvent>(
      (event, emit) async {
        requestDate = DateTime.now();
        emit(
          await _loadData(
            initDate: initialDateFilter,
            endDate: finalDateFilter,
            isPeriodSelected: isPeriodSelected,
            isEmployeesSelected: isEmployeesSelected,
            employeesIds: employeesIds,
          ),
        );
      },
    );

    on<BackWeekPeriodEvent>(
      (event, emit) async {
        final today = _internalClockService.getClockDateTime();
        final initialLimitDate = today.subtract(const Duration(days: 60));

        DateTime priorPeriodDateTime = DateTime(
          initialDateFilter.year,
          initialDateFilter.month - 1,
          initialDateFilter.day,
        );

        initialDateFilter = _utils.firstDayOfTheMonth(priorPeriodDateTime);
        finalDateFilter = _utils.lastDayOfTheMonth(priorPeriodDateTime);

        if (initialDateFilter.isBefore(initialLimitDate)) {
          initialDateFilter = initialLimitDate;
        }

        if (finalDateFilter.isAfter(today)) {
          finalDateFilter = today;
        }

        if (finalDateFilter.isBefore(initialDateFilter)) {
          return;
        }

        emit(
          await _loadData(
            initDate: initialDateFilter,
            endDate: finalDateFilter,
            isPeriodSelected: isPeriodSelected,
            isEmployeesSelected: isEmployeesSelected,
            employeesIds: employeesIds,
          ),
        );
      },
    );

    on<AheadWeekPeriodEvent>(
      (event, emit) async {
        DateTime today = _internalClockService.getClockDateTime();
        final initialLimitDate = today.subtract(const Duration(days: 60));

        DateTime nextPeriodDateTime = DateTime(
          initialDateFilter.year,
          initialDateFilter.month + 1,
          initialDateFilter.day,
        );

        initialDateFilter = _utils.firstDayOfTheMonth(nextPeriodDateTime);
        finalDateFilter = _utils.lastDayOfTheMonth(nextPeriodDateTime);

        if (initialDateFilter.isBefore(initialLimitDate)) {
          initialDateFilter = initialLimitDate;
        }

        if (finalDateFilter.isAfter(today)) {
          finalDateFilter = today;
        }

        if (initialDateFilter.isAfter(finalDateFilter)) {
          return;
        }

        emit(
          await _loadData(
            initDate: initialDateFilter,
            endDate: finalDateFilter,
            isPeriodSelected: isPeriodSelected,
            isEmployeesSelected: isEmployeesSelected,
            employeesIds: employeesIds,
          ),
        );
      },
    );

    on<FilterEmployeeEvent>(
      (event, emit) async {
        emit(LoadingDayInfoState());
        isEmployeesSelected = event.isEmployeesSelected;
        employeesIds = event.employeesIds;
        emit(
          await _loadData(
            initDate: initialDateFilter,
            endDate: finalDateFilter,
            isPeriodSelected: isPeriodSelected,
            isEmployeesSelected: event.isEmployeesSelected,
            employeesIds: event.employeesIds,
          ),
        );
      },
    );

    on<FilterPeriodEvent>(
      (event, emit) async {
        emit(LoadingDayInfoState());

        isPeriodSelected = event.isPeriodSelected;
        initialDateFilter = event.initDate;
        finalDateFilter = event.endDate;

        final today = _internalClockService.getClockDateTime();

        if (finalDateFilter.isAfter(today)) {
          finalDateFilter = today;
        }

        emit(
          await _loadData(
            initDate: initialDateFilter,
            endDate: finalDateFilter,
            isPeriodSelected: isPeriodSelected,
            isEmployeesSelected: isEmployeesSelected,
            employeesIds: employeesIds,
          ),
        );
      },
    );
  }

  Future<PeriodState> todayPeriod() async {
    DateTime today = _internalClockService.getClockDateTime();
    final initialLimitDate = today.subtract(const Duration(days: 60));

    isPeriodSelected = false;
    initialDateFilter = _utils.firstDayOfTheMonth(today);
    finalDateFilter = _utils.lastDayOfTheMonth(today);

    if (initialDateFilter.isBefore(initialLimitDate)) {
      initialDateFilter = initialLimitDate;
    }

    if (finalDateFilter.isAfter(today)) {
      finalDateFilter = today;
    }

    return await _loadData(
      initDate: initialDateFilter,
      endDate: finalDateFilter,
      isPeriodSelected: false,
      isEmployeesSelected: isEmployeesSelected,
      employeesIds: employeesIds,
    );
  }

  Future<PeriodState> _loadData({
    required DateTime initDate,
    required DateTime endDate,
    required bool isPeriodSelected,
    required bool isEmployeesSelected,
    List<String>? employeesIds,
  }) async {
    List<DayInfoModel> dayInfoModelList = [];
    EmployeeDto? employeeDto = _getEmployeeUsecase.call();
    DateTime finalDateGenerate =
        isPeriodSelected ? endDate : calcFinalDateGenerate(endDate);
    List<ClockingEventDto> dtoList = [];
    List<OvernightEntity> dtoOvernight = [];

    if (employeeDto != null) {
      dtoOvernight = await _overnightRepository.findByEmployee(
        employeeId: employeeDto.id,
      );
      List<ClockingEvent> entitiyList = await _clockingEventRepository.findByEmployeeAndPeriod(
        initDate: initDate,
        endDate: endDate,
        employeeId: employeeDto.id,
        orderingMode: OrderingModeEnum.desc,
      );
      dtoList = await _clockingEventMapper.fromEntityToDtoCollectorList(entitiyList);
    }

    if (username != null && username!.isNotEmpty) {
      var admin =
          await _verifyUserLoggedIsAdminUsecase.call(username: username!);
      var manager =
          await _verifyUserLoggedIsManagerUsecase.call(username: username!);

      if (admin || manager) {
        List<ClockingEvent> entitiyList = await _clockingEventRepository.findByPeriod(
          initDate: initDate,
          endDate: endDate,
          orderingMode: OrderingModeEnum.desc,
        );
        dtoList = await _clockingEventMapper.fromEntityToDtoCollectorList(entitiyList);
      }

      if (!admin && manager) {
        dtoList = await _getClockingEventByManagerUsecase.call(
          appointments: dtoList,
          username: username!,
        );
      }

      if (!admin && !manager) {
        var employeeDto =
            await _findEmployeeIdByUsernameUsecase.call(username: username!);
        List<ClockingEvent> entitiyList = await _clockingEventRepository.findByEmployeeAndPeriod(
          initDate: initDate,
          endDate: endDate,
          employeeId: employeeDto?.id ?? '',
          orderingMode: OrderingModeEnum.desc,
        );
        dtoList = await _clockingEventMapper.fromEntityToDtoCollectorList(entitiyList);
      }
    }

    if (isEmployeesSelected &&
        employeesIds != null &&
        employeesIds.isNotEmpty) {
      dtoList = dtoList
          .where((e) => employeesIds.contains(e.employeeDto?.id))
          .toList();
    }

    dayInfoModelList = await _dayInfoService.generate(
      clockingEvents: dtoList,
      initialDate: initDate,
      finalDate: finalDateGenerate,
      overnights: dtoOvernight,
    );

    dayInfoModelList.sort(
      (a, b) => b.day.compareTo(a.day),
    );

    dayInfoModelList.sort(
      (a, b) => b.day.compareTo(a.day),
    );

    return LoadedDayInfoState(
      data: dayInfoModelList,
    );
  }

  DateTime calcFinalDateGenerate(DateTime endDate) {
    DateTime finalDateGenerate = _internalClockService.getClockDateTime();
    if (endDate.month < finalDateGenerate.month) {
      finalDateGenerate = endDate;
    }
    return finalDateGenerate;
  }
}
