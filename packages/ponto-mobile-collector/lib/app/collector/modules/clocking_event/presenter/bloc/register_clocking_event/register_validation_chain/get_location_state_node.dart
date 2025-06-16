import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/usecases/get_location_usecase.dart';
import 'register_validation_node.dart';

class GetLocationStateNode extends RegisterValidationNode {
  final IPermissionService _permissionService;
  final GetLocationUsecase _getLocationUsecase;
  final LogService _logService;
  late RegisterClockingEventBloc _registerClockingEventBloc;
  @visibleForTesting
  bool get isUnitTesting => Platform.environment.containsKey('FLUTTER_TEST');

  GetLocationStateNode({
    required IPermissionService permissionService,
    required GetLocationUsecase getLocationUsecase,
    required LogService logService,
  })  : _permissionService = permissionService,
        _getLocationUsecase = getLocationUsecase,
        _logService = logService;

  void setContext(
    RegisterClockingEventBloc registerClockingEventBloc,
  ) {
    _registerClockingEventBloc = registerClockingEventBloc;
  }

  @override
  Future<dynamic> handler() async {
    DateTime initDateTime = DateTime.now();
    log('##INFO## Stating GetLocationStateNode ${DateTime.now()}');

    if (_registerClockingEventBloc.clockingEventRegisterEntity.location ==
        null) {
      DevicePermissionEnum permissionType = DevicePermissionEnum.location;

      PermissionStatus permissionStatus =
          await _permissionService.check(permission: permissionType);

      final hasPermission = permissionStatus.isGranted;

      if (hasPermission) {
        StateLocationEntity? location;
        try {
          location = await _getLocationUsecase.call();

          _registerClockingEventBloc.clockingEventRegisterEntity.location =
              location;

          String logMsg =
              'Location obtained, Latitude: ${location?.latitude}, Longitude: ${location?.longitude} at ${DateTime.now()}';

          _logService.saveLocalLog(
            exception: 'GetLocationStateNode',
            stackTrace: logMsg,
          );

          log('GetLocationStateNode: $logMsg');
        } catch (e) {
          _logService.saveLocalLog(
            exception: 'GetLocationStateNode',
            stackTrace:
                'Location not obtained: ${e.toString()} at ${DateTime.now()}',
          );
        }
      }

      // If location is still null assign default location
      if (_registerClockingEventBloc.clockingEventRegisterEntity.location ==
          null) {
        _registerClockingEventBloc.clockingEventRegisterEntity.location ??=
            StateLocationEntity(
          hasPermission: hasPermission,
          isServiceEnabled: hasPermission,
          success: hasPermission,
          isMock: true,
        );

        _logService.saveLocalLog(
          exception: 'GetLocationStateNode',
          stackTrace:
              'Location not obtained, hasPermission: $hasPermission, at ${DateTime.now()}',
        );
      }
    }

    _logService.saveLocalLog(
      exception: 'GetLocationStateNode',
      stackTrace:
          'Current Location, Latitude: ${_registerClockingEventBloc.clockingEventRegisterEntity.location} at ${DateTime.now()}',
    );

    log('##INFO## Finish GetLocationStateNode ${DateTime.now()}');
    Duration totalDuration = DateTime.now().difference(initDateTime);
    log('GetLocationStateNode: #ProcessingTime: ${totalDuration.toString()}');
    return super.handler();
  }
}
