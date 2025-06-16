import '../../../../../ponto_mobile_collector.dart';
import '../../external/mappers/activation_mapper.dart';
import '../entities/activation.dart';
import '../input_model/activation_dto.dart';

abstract class GetEmployeeActivationUsecase {
  Future<ActivationDto?> call({required String employeeId});
}

class GetEmployeeActivationUsecaseImpl implements GetEmployeeActivationUsecase {
  final IActivationRepository _activationRepository;

  GetEmployeeActivationUsecaseImpl({
    required IActivationRepository activationRepository,
  }) : _activationRepository = activationRepository;

  @override
  Future<ActivationDto?> call({required String employeeId}) async {
    Activation? entityActivation =  await _activationRepository.findByEmployeeId(employeeId: employeeId);
    return ActivationMapper.fromEntityToDtoCollector(entityActivation);
  }
}
