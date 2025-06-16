import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../domain/usecase/employee_has_recent_clocking_event_usecase.dart';
import 'register_validation_node.dart';

class GetRecentStatusStateNode extends RegisterValidationNode {
  final IEmployeeHasRecentClockingEventUsecase
      _employeeHasRecentClockingEventUsecase;
  final NavigatorService _navigatorService;
  late RegisterClockingEventBloc _registerClockingEventBloc;
  final LogService _logService;
  late BuildContext _context;

  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  GetRecentStatusStateNode({
    required IEmployeeHasRecentClockingEventUsecase
        employeeHasRecentClockingEventUsecase,
    required NavigatorService navigatorService,
    required LogService logService,
  })  : _employeeHasRecentClockingEventUsecase =
            employeeHasRecentClockingEventUsecase,
        _navigatorService = navigatorService,
        _logService = logService;

  void setContext(
    BuildContext context,
    RegisterClockingEventBloc registerClockingEventBloc,
  ) {
    _context = context;
    _registerClockingEventBloc = registerClockingEventBloc;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## Stating GetRecentStatusStateNode ${DateTime.now()}');
    bool cancelRegistration = false;

    final ClockingEventRegisterEntity(
      :employeeDto,
      :clockingEventRegisterType,
    ) = _registerClockingEventBloc.clockingEventRegisterEntity;

    bool employeeHasRecentClockingEvent =
        await _employeeHasRecentClockingEventUsecase.call(
      employeeId: employeeDto!.id,
      clockingEventRegisterType: clockingEventRegisterType,
    );

    if (employeeHasRecentClockingEvent == true) {
      cancelRegistration = await getRecentStatusState();
    }

    _logService.saveLocalLog(
      exception: 'GetRecentStatusStateNode',
      stackTrace:
          'employeeHasRecentClockingEvent: $employeeHasRecentClockingEvent, cancelRegistration: $cancelRegistration at ${DateTime.now()}',
    );

    log('##INFO## Finish GetRecentStatusStateNode ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetRecentStatusStateNode: #ProcessingTime: ${totalDuration.toString()}');
    return cancelRegistration ? false : super.handler();
  }

  Future<bool> getRecentStatusState() async {
    bool cancelRegistration = true;

    await showDialog(
      context: _context,
      builder: (context) {
        return SeniorModal(
          title: isUnitTesting
              ? 'alert'
              : CollectorLocalizations.of(_context).alert,
          content: isUnitTesting
              ? 'content'
              : CollectorLocalizations.of(_context).recentClockingEventMessage,
          otherAction: SeniorModalAction(
            label: isUnitTesting
                ? 'cancel'
                : CollectorLocalizations.of(_context).cancelAppointment,
            danger: true,
            action: () {
              _navigatorService.pop();
            },
          ),
          defaultAction: SeniorModalAction(
            label: isUnitTesting
                ? 'confirm'
                : CollectorLocalizations.of(_context).confirmAppointment,
            action: () {
              cancelRegistration = false;
              _navigatorService.pop();
            },
          ),
        );
      },
    );

    return cancelRegistration;
  }
}
