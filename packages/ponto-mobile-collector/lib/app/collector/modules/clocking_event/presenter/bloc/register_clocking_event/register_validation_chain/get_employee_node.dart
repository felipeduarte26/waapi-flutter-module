import 'dart:developer';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../../../core/domain/input_model/employee_dto.dart';
import '../../../../../../core/external/mappers/employee_mapper.dart';
import 'register_validation_node.dart';

class GetEmployeeNode extends RegisterValidationNode {
  late RegisterClockingEventBloc _registerClockingEventBloc;
  final IEmployeeRepository _employeeRepository;
  final ISessionService _sessionService;
  final LogService _logService;

  GetEmployeeNode({
    required ISessionService sessionService,
    required IEmployeeRepository employeeRepository,
    required LogService logService,
  })  : _sessionService = sessionService,
        _employeeRepository = employeeRepository,
        _logService = logService;

  void setContext(
    RegisterClockingEventBloc registerClockingEventBloc,
  ) {
    _registerClockingEventBloc = registerClockingEventBloc;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## GetEmployeeNode started: ${DateTime.now()}');
    EmployeeDto? employeeDto;
    String? employeeId;
    ClockingEventRegisterType regiterType = _registerClockingEventBloc
        .clockingEventRegisterEntity.clockingEventRegisterType;

    switch (regiterType) {
      case ClockingEventRegisterTypeSession _:
      case ClockingEventRegisterTypeDriver _:
        employeeDto = _sessionService.getEmployee();
        break;
      case ClockingEventRegisterTypeNFC _:
        employeeId = regiterType.employeeId;
        break;
      case ClockingEventRegisterTypeQRCode _:
        employeeId = regiterType.employeeId;
        break;
      case ClockingEventRegisterTypeFacialRecognition _:
        employeeId = regiterType.employeeId;
        break;
      case ClockingEventRegisterTypeEmailPassword _:
        employeeId = regiterType.employeeId;
        break;
    }

    if (employeeId != null) {
       var entity = await _employeeRepository.findById(id: employeeId);
       employeeDto = EmployeeMapper.fromEntityToDtoCollector(entity);
    }

    _logService.saveLocalLog(
      exception: 'GetEmployeeNode',
      stackTrace:
          'RegiterType: ${regiterType.runtimeType}, Received ID: $employeeId, Employee found: ${employeeDto?.id} at ${DateTime.now()}',
    );

    _registerClockingEventBloc.clockingEventRegisterEntity.employeeDto =
        employeeDto;
    
    log('##INFO## GetEmployeeNode finished: ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetEmployeeNode: #ProcessingTime: ${totalDuration.toString()}');
    return super.handler();
  }
}
