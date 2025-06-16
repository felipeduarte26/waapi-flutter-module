import '../../external/mappers/device_mapper.dart';
import '../../infra/repositories/database/device_repository.dart';
import '../entities/device.dart';

abstract class GetDeviceUsecase {
  Future<Device?> call(String identifier);
}

class GetDeviceUsecaseImpl implements GetDeviceUsecase {
  final DeviceRepository _deviceRepository;
  Duration get timeLimit => const Duration(seconds: 3);
  GetDeviceUsecaseImpl({
    required DeviceRepository deviceRepository,
  })  : _deviceRepository = deviceRepository;

  @override
  Future<Device?> call(String identifier) async {


    var findByIdentifier =
    await _deviceRepository.findByIdentifier(id: identifier);
    if (findByIdentifier != null) {
      var fromTable = DeviceMapper().fromTable(findByIdentifier);
      return fromTable;
    }

    return null;
  }
}
