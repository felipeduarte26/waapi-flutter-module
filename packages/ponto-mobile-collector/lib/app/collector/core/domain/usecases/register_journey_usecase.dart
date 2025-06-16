import 'package:uuid/uuid.dart';

import '../../../../../ponto_mobile_collector.dart';
import '../entities/journey_entity.dart';

abstract class IRegisterJourneyUsecase {
  Future<JourneyEntity> call({
    required DateTime dateTimeEvent,
  });
}

class RegisterJourneyUsecase implements IRegisterJourneyUsecase {
  final IJourneyRepository _journeyRepository;
  final ISessionService _sessionService;

  RegisterJourneyUsecase({
    required IJourneyRepository journeyRepository,
    required ISessionService sessionService,
  })  : _journeyRepository = journeyRepository,
        _sessionService = sessionService;

  @override
  Future<JourneyEntity> call({
    required DateTime dateTimeEvent,
  }) async {
    final uuid = const Uuid().v4();
    final employeeId = _sessionService.getEmployeeId();
    final newJourneyEntity = JourneyEntity(
      id: uuid,
      employeeId: employeeId,
      startDate: dateTimeEvent,
    );

    await _journeyRepository.save(
      journeyEntity: newJourneyEntity,
    );

    final savedJourneyEntity = await _journeyRepository.findById(
      id: uuid,
    );

    return savedJourneyEntity!;
  }
}
