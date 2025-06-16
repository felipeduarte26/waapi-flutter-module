import 'package:ponto_mobile_collector/app/collector/core/domain/entities/activation.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';

Activation activationEntityMock =  const Activation(
  deviceSituation: StatusDevice.authorized,
  employeeSituation: ActivationSituationType.authorized,
  requestDate: 'requestDate',
  requestTime: 'requestTime',
);
