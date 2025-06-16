import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../domain/usecase/check_employee_in_fences_usecase.dart';
import 'register_validation_node.dart';

class GetFenceStatusStateNode extends RegisterValidationNode {
  final ICheckEmployeeInFencesUsecase _checkEmployeeInFencesUsecase;
  final NavigatorService _navigatorService;
  final LogService _logService;
  late RegisterClockingEventBloc _registerClockingEventBloc;
  late BuildContext _context;
  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  GetFenceStatusStateNode({
    required ICheckEmployeeInFencesUsecase checkEmployeeInFencesUsecase,
    required NavigatorService navigatorService,
    required LogService logService,
  })  : _checkEmployeeInFencesUsecase = checkEmployeeInFencesUsecase,
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
    log('##INFO## Stating GetFenceStatusStateNode ${DateTime.now()}');
    bool cancelRegistration = false;
    bool employeeIsInFence = _checkEmployeeInFencesUsecase.call(
      fences: _registerClockingEventBloc
          .clockingEventRegisterEntity.employeeDto!.fences,
      location:
          _registerClockingEventBloc.clockingEventRegisterEntity.location!,
      fencesDto: _registerClockingEventBloc
          .clockingEventRegisterEntity.employeeDto!.fences,
    );

    if (_registerClockingEventBloc
            .clockingEventRegisterEntity.location!.success &&
        employeeIsInFence == false) {
      cancelRegistration = await showAlertFenceDialog();

      _logService.saveLocalLog(
        exception: 'GetFenceStatusStateNode',
        stackTrace:
            'Validated Fence, CancelRegistration: $cancelRegistration, at ${DateTime.now()}',
      );
    }

    _logService.saveLocalLog(
      exception: 'GetFenceStatusStateNode',
      stackTrace:
          'CancelRegistration: $cancelRegistration, EmployeeIsInFence: $employeeIsInFence at ${DateTime.now()}',
    );

    log('##INFO## Finish GetFenceStatusStateNode ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetFenceStatusStateNode: #ProcessingTime: ${totalDuration.toString()}');
    return cancelRegistration ? false : super.handler();
  }

  Future<bool> showAlertFenceDialog() async {
    bool cancelRegistration = true;

    await showDialog(
      context: _context,
      builder: (BuildContext context) {
        return SeniorModal(
          title: isUnitTesting
              ? 'title'
              : CollectorLocalizations.of(_context).alert,
          content: isUnitTesting
              ? 'message'
              : CollectorLocalizations.of(_context).outsideTheFenceMessage,
          otherAction: SeniorModalAction(
            label: isUnitTesting
                ? 'cancel'
                : CollectorLocalizations.of(_context).cancelAppointment,
            danger: true,
            action: () {
              cancelRegistration = true;
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
