import 'package:ponto_mobile_collector/app/collector/core/domain/entities/device.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/status_device.dart';

Device deviceEntityMock = const Device(
  id: 'id',
  identifier: 'imei',
  status: StatusDevice.authorized,
  model: 'model',
  name: 'name',
);
