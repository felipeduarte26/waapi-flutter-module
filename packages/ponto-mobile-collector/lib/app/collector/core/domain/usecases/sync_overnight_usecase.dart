import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:intl/intl.dart';

import '../../infra/services/environment/environment_service.dart';
import '../../infra/utils/enum/environment_enum.dart';
import '../repositories/database/iovernight_repository.dart';

abstract class SyncOvernightUsecase {
  Future<bool> call();
}

class SyncOvernightUsecaseImpl implements SyncOvernightUsecase {
  final IOvernightRepository _overnightRepository;
  final OvernightImportService _overnightImportService;
  final EnvironmentService _environmentService;

  SyncOvernightUsecaseImpl({
    required IOvernightRepository overnightRepository,
    required OvernightImportService overnightImportService,
    required EnvironmentService environmentService,
  })  : _overnightRepository = overnightRepository,
        _overnightImportService = overnightImportService,
        _environmentService = environmentService;

  @override
  Future<bool> call() async {
    var findNotSynchronized = await _overnightRepository.findNotSynchronized();

    List<OvernightImportDto> overnightImportDtoList = [];

    for (var overnightEntity in findNotSynchronized) {
      overnightImportDtoList.add(
        OvernightImportDto(
          id: overnightEntity.id,
          date: DateFormat('yyyy-MM-dd').format(overnightEntity.date),
          type: overnightEntity.type,
          employee: overnightEntity.employee,
          externalId: overnightEntity.id,
          geolocation: overnightEntity.geolocation,
          locationStatus: overnightEntity.locationStatus,
        ),
      );
    }

    try {
      var overnightImportDto = await _overnightImportService.call(
        overnightImportDtoList: overnightImportDtoList,
        environment: EnvironmentEnum.mapToClock(
          _environmentService.environment(),
        ),
      );
      var bool = overnightImportDto?.overnights.length ==
          overnightImportDtoList.length;

      if (!bool) {
        return false;
      }

      for (var overnightEntity in findNotSynchronized) {
        overnightEntity = overnightEntity.copyWith(synchronized: true);
        await _overnightRepository.save(overnightEntity: overnightEntity);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
