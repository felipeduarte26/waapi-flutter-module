
import '../../../../core/domain/repositories/database/i_device_configuration_repository.dart';

abstract class IGetDeviceFaceRecognitionUsecase {
  Future<bool> call();
}

class GetDeviceFaceRecognitionUsecase implements IGetDeviceFaceRecognitionUsecase {
  final IDeviceConfigurationRepository configurationRepository;

  GetDeviceFaceRecognitionUsecase({ required this.configurationRepository,
  });

  @override
  Future<bool> call() async {

    var show = await configurationRepository.getConfiguration();

    if(show != null && show.enableFacial) {
      return true;
    } else {
      return false;
    }
  }
}
