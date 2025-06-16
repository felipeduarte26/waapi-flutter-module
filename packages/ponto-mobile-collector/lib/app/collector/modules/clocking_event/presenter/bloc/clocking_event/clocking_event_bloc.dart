import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/mobile_authentication_service.dart'
    as auth;

import '../../../../../../../ponto_mobile_collector.dart';
import '../../../../../core/domain/input_model/clocking_event_dto.dart';
import '../../../../../core/domain/input_model/company_dto.dart';
import '../../../../../core/domain/input_model/employee_dto.dart';
import '../../../../../core/domain/usecases/get_execution_mode_usecase.dart';
import '../../../../../core/external/mappers/clocking_event_mapper.dart';
import '../../../../../core/infra/utils/enum/execution_mode_enum.dart';
import '../../../domain/usecase/get_clock_time_usecase.dart';
import '../../../domain/usecase/get_company_dto_usecase.dart';
import '../../../domain/usecase/get_employee_dto_usecase.dart';
import '../../../domain/usecase/get_employee_usecase.dart';

class ClockingEventBloc
    extends Bloc<ClockingEventEvent, ClockingEventBaseState> {
  final IGetClockDateTimeUsecase _getClockDateTimeUsecase;
  final IClockingEventRepository _clockingEventRepository;
  final IGetEmployeeDtoUsecase _getEmployeeDtoUsecase;
  final IGetCompanyDtoUsecase _getCompanyDtoUsecase;
  final IGetEmployeeUsecase _getEmployeeUsecase;
  final ISessionService _sessionService;
  final IUtils _utils;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final ClockingEventMapper _clockingEventMapper;

  final List<ClockingEventDto> _clockingEventsDto = [];

  List<ClockingEventDto> get clockingEvents => _clockingEventsDto;

  bool _expandTodaysWorkday = false;

  bool get expandTodaysWorkday => _expandTodaysWorkday;
  ExecutionModeEnum executionModeEnum = ExecutionModeEnum.none;

  ClockingEventBloc(
    this._getClockDateTimeUsecase,
    this._clockingEventRepository,
    this._getEmployeeUsecase,
    this._getCompanyDtoUsecase,
    this._getEmployeeDtoUsecase,
    this._sessionService,
    this._utils,
    this._getExecutionModeUsecase,
    this._clockingEventMapper,
  ) : super(InitialClockingEventState()) {
    on<LoadClockingEventEvent>(
      (event, emit) async {
        emit(LoadingClockingEventState());

        executionModeEnum = await _getExecutionModeUsecase.call();

        EmployeeDto? employeeDto = _getEmployeeUsecase.call();

        if (employeeDto != null) {
          List<ClockingEvent> entity =
              await _clockingEventRepository.findByDate(
            date: _getClockDateTimeUsecase.call(),
            employeeId: employeeDto.id.toString(),
            filterByUse: auth.ClockingEventUseType.clockingEvent,
          );
          List<ClockingEventDto> loadedData = await _clockingEventMapper.fromEntityToDtoCollectorList(entity);

          CompanyDto? companyDto;

          if (loadedData.isNotEmpty) {
            companyDto = await _getCompanyDtoUsecase.call(
              id: employeeDto.company.id.toString(),
            );

            employeeDto = await _getEmployeeDtoUsecase.call(
              id: loadedData.first.id.toString(),
            );
          }

          _clockingEventsDto.clear();

          for (ClockingEventDto clockingEvent in loadedData) {
            clockingEvent.companyDto = companyDto;
            clockingEvent.employeeDto = employeeDto;
            _clockingEventsDto.add(clockingEvent);
          }
        }

        emit(
          ReadyContentClockingEventState(
            clockingEventsDto: _clockingEventsDto,
          ),
        );
      },
    );

    on<ChangeExpandedTodaysClockingEventEvent>(
      (event, emit) async {
        _expandTodaysWorkday = !_expandTodaysWorkday;
        emit(ChangeTodayClockingEventState());
      },
    );

    on<BusyClockingEvent>(
      (event, emit) async {
        emit(LoadingClockingEventState());
      },
    );

    on<ShowPreloadedDataEvent>(
      (event, emit) async {
        emit(
          ReadyContentClockingEventState(
            clockingEventsDto: _clockingEventsDto,
          ),
        );
      },
    );

    on<ClockingEventLoadingLocationEvent>((event, emit) async {
      emit(
        ClockingEventLoadingLocationState(),
      );
    });
  }

  String? getEmployeeName() {
    return _sessionService.getEmployee().name;
  }

  bool hasEmployee() {
    return _sessionService.hasEmployee();
  }

  String? deviceStatus(BuildContext context) {
    String? errorMessage;
    ExecutionModeEnum executionModeEnum = _sessionService.getExecutionMode();

    if (_sessionService.checkDeviceStatus() !=
            DeviceAuthorizationStatusEnum.authorized ||
        !executionModeEnum.isIndividualOrDriver()) {
      errorMessage = _utils.getDeviceStatusMessage(
        context,
        _sessionService.checkDeviceStatus(),
      );

      if (!executionModeEnum.isIndividualOrDriver()) {
        errorMessage =
            CollectorLocalizations.of(context).clockingEventSingleNotAvailable;
      }
    }

    return errorMessage;
  }
}
