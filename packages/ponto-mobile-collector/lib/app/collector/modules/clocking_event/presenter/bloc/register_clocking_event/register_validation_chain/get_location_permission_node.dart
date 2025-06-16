import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/services/navigator/navigator_service.dart';
import 'register_validation_node.dart';

class GetLocationPermissionNode extends RegisterValidationNode {
  final IPermissionService _permissionService;
  final NavigatorService _navigatorService;
  final LogService _logService;
  late BuildContext _context;

  GetLocationPermissionNode({
    required IPermissionService permissionService,
    required NavigatorService navigatorService,
    required LogService logService,
  })  : _permissionService = permissionService,
        _navigatorService = navigatorService,
        _logService = logService;

  void setContext(
    BuildContext context,
  ) {
    _context = context;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## Stating GetLocationPermissionNode ${DateTime.now()}');
    DevicePermissionEnum permissionType = DevicePermissionEnum.location;

    PermissionStatus permissionStatus =
        await _permissionService.check(permission: permissionType);

    if (permissionStatus.isDenied) {
      permissionStatus =
          await _permissionService.request(permission: permissionType);

      _logService.saveLocalLog(
        exception: 'GetLocationPermissionNode',
        stackTrace:
            'Current permissionStatus.isDenied: ${permissionStatus.isDenied}, New Status: ${permissionStatus.isDenied} at ${DateTime.now()}',
      );
    }

    if (permissionStatus.isPermanentlyDenied) {
      await showPermissionIsDeniedMessage();
      _logService.saveLocalLog(
        exception: 'GetLocationPermissionNode',
        stackTrace:
            'Permission permanently denied, requested to user sent at ${DateTime.now()}',
      );
    }

    _logService.saveLocalLog(
      exception: 'GetLocationPermissionNode',
      stackTrace:
          'Location permission status: ${permissionStatus.name} at ${DateTime.now()}',
    );

    log('##INFO## Finish GetLocationPermissionNode ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetLocationPermissionNode: #ProcessingTime: ${totalDuration.toString()}');
    return super.handler();
  }

  Future<void> showPermissionIsDeniedMessage() async {
    await showDialog(
      context: _context,
      builder: (context) {
        return SeniorModal(
          title: CollectorLocalizations.of(_context).alert,
          content: CollectorLocalizations.of(_context)
              .permissionLocationNotAllowedMessage,
          otherAction: SeniorModalAction(
            label: CollectorLocalizations.of(_context).goToConfiguration,
            danger: false,
            action: () async {
              await _permissionService.openSystemAppSettings();
            },
          ),
          defaultAction: SeniorModalAction(
            label: CollectorLocalizations.of(_context).continueAction,
            action: () async {
              _navigatorService.pop();
            },
          ),
        );
      },
    );
  }
}
