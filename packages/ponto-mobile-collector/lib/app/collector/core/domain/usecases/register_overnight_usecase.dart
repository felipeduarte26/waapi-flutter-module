import 'package:dart_mobile_clocking_event/dart_mobile_clocking_event.dart';
import 'package:uuid/uuid.dart';

import '../../../../../ponto_mobile_collector.dart';
import '../entities/overnight_entity.dart';
import 'sync_overnight_usecase.dart';

abstract class IRegisterOvernightUsecase {
  Future<OvernightEntity> call({
    required DateTime dateTimeEvent,
    required bool manual,
    required String employeeId,
    LocationDTO? locationDTO,
    LocationStatusEnum? locationStatus,
  });
}

class RegisterOvernightUsecase implements IRegisterOvernightUsecase {
  final IOvernightRepository _overnightRepository;
  final SyncOvernightUsecase _syncOvernightUsecase;

  RegisterOvernightUsecase({
    required IOvernightRepository overnightRepository,
    required SyncOvernightUsecase syncOvernightUsecase,
  })  : _overnightRepository = overnightRepository,
        _syncOvernightUsecase = syncOvernightUsecase;

  @override
  Future<OvernightEntity> call({
    required DateTime dateTimeEvent,
    required bool manual,
    required String employeeId,
    LocationDTO? locationDTO,
    LocationStatusEnum? locationStatus,
  }) async {
    final uuid = const Uuid().v4();
    final newOvernightEntity = OvernightEntity(
      id: uuid,
      date: dateTimeEvent,
      locationStatus: locationStatus ?? LocationStatusEnum.noLocation,
      geolocation: locationDTO,
      employee: EmployeeDto(
        id: employeeId,
        name: '',
        employeeType: '',
        cpf: '',
      ),
      type: manual ? 'MANUAL' : 'SYSTEM',
      synchronized: false,
    );

    await _overnightRepository.save(
      overnightEntity: newOvernightEntity,
    );

    final savedOvernightEntity = await _overnightRepository.findById(
      id: uuid,
    );

    await _syncOvernightUsecase.call();

    return savedOvernightEntity!;
  }
}
