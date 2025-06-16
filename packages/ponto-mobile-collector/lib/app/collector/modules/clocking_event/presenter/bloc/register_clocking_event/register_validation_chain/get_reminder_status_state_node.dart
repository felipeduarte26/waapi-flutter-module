import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../domain/usecase/employee_has_reminder_clocking_event_usecase.dart';
import 'register_validation_node.dart';

class GetReminderStatusStateNode extends RegisterValidationNode {
  final IEmployeeHasReminderClockingEventUseCase
      _employeeHasReminderClockingEventUseCase;
  final NavigatorService _navigatorService;
  final LogService _logService;
  late RegisterClockingEventBloc _registerClockingEventBloc;
  late BuildContext _context;

  GetReminderStatusStateNode({
    required IEmployeeHasReminderClockingEventUseCase
        employeeHasReminderClockingEventUseCase,
    required NavigatorService navigatorService,
    required LogService logService,
  })  : _employeeHasReminderClockingEventUseCase =
            employeeHasReminderClockingEventUseCase,
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
    log('##INFO## Stating GetReminderStatusStateNode ${DateTime.now()}');
    bool cancelRegistration = false;

    final clockingEventRegisterEntity =
        _registerClockingEventBloc.clockingEventRegisterEntity;
    final employeeId = clockingEventRegisterEntity.employeeDto!.id;
    final clockingEventRegisterType =
        clockingEventRegisterEntity.clockingEventRegisterType;

    var value = await _employeeHasReminderClockingEventUseCase.callIntraJourney(
      employeeId: employeeId,
      clockingEventRegisterType: clockingEventRegisterType,
    );

    if (value != null) {
      cancelRegistration =
          await getReminderStatusState(ReminderType.intrajourney, value);
    }

    if (!cancelRegistration) {
      value = await _employeeHasReminderClockingEventUseCase.callInterJourney(
        employeeId: employeeId,
        clockingEventRegisterType: clockingEventRegisterType,
      );

      if (value != null) {
        cancelRegistration =
            await getReminderStatusState(ReminderType.interjourney, value);
      }
    }

    _logService.saveLocalLog(
      exception: 'GetReminderStatusStateNode',
      stackTrace:
          'CancelRegistration: $cancelRegistration, HasReminderClockingEvent: $value, at ${DateTime.now()}',
    );

    log('##INFO## Finish GetReminderStatusStateNode ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetReminderStatusStateNode: #ProcessingTime: ${totalDuration.toString()}');
    return cancelRegistration ? false : super.handler();
  }

  Future<bool> getReminderStatusState(
    ReminderType reminderType,
    DateTime time,
  ) async {
    bool cancelRegistration = true;

    await showDialog(
      context: _context,
      builder: (context) {
        String content = reminderType == ReminderType.intrajourney
            ? CollectorLocalizations.of(_context)
                .reminderClockingEventMessageIntraJourney(
                Utils().formatTimeQuantitative(
                  dateTime: time,
                  locale: CollectorLocalizations.of(_context).localeName,
                ),
              )
            : CollectorLocalizations.of(_context)
                .reminderClockingEventMessageInterJourney(
                Utils().formatTimeQuantitative(
                  dateTime: time,
                  locale: CollectorLocalizations.of(_context).localeName,
                ),
              );

        return SeniorModal(
          title: CollectorLocalizations.of(_context).alert,
          content: content,
          otherAction: SeniorModalAction(
            label: CollectorLocalizations.of(_context).cancelAppointment,
            danger: true,
            action: () {
              _navigatorService.pop();
            },
          ),
          defaultAction: SeniorModalAction(
            label: CollectorLocalizations.of(_context).confirmAppointment,
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
