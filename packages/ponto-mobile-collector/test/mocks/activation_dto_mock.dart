import 'package:ponto_mobile_collector/app/collector/core/domain/enums/activation_situation_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/activation_dto.dart';

ActivationDto activationDtoMock =  ActivationDto(
  deviceSituation: StatusDevice.authorized,
  employeeSituation: ActivationSituationType.authorized,
  requestDate: 'requestDate',
  requestTime: 'requestTime',
);
