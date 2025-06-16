import '../../domain/entities/device.dart';

abstract class GetDeviceDatasource {
  Future<Device?> call(String identifier);
}
