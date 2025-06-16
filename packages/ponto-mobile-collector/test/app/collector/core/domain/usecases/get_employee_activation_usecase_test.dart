import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/database/iactivation_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_employee_activation_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/external/mappers/activation_mapper.dart';

import '../../../../../mocks/activation_entity_mock.dart';

class MockActivationRepository extends Mock implements IActivationRepository {}

void main() {
  const String employeeId = '123456789';

  late IActivationRepository activationRepository;

  late GetEmployeeActivationUsecase usecase;

  setUp(() {
    activationRepository = MockActivationRepository();

    usecase = GetEmployeeActivationUsecaseImpl(
      activationRepository: activationRepository,
    );

    when(
      () => activationRepository.findByEmployeeId(employeeId: employeeId),
    ).thenAnswer((invocation) => Future.value(activationEntityMock));
  });

  test(
    'GetEmployeeActivationUsecase test',
    () async {
      var employeeActivation = await usecase.call(employeeId: employeeId);

      var activationEntity = ActivationMapper.fromEntityToDtoCollector(activationEntityMock);

      when(() => activationRepository.findByEmployeeId(employeeId: employeeId)).thenAnswer((invocation) => Future.value(activationEntityMock));

      expect(employeeActivation!.deviceSituation, activationEntity!.deviceSituation);
      expect(employeeActivation.employeeSituation, activationEntity.employeeSituation);
      expect(employeeActivation.id, activationEntity.id);
      expect(employeeActivation.requestDate, activationEntity.requestDate);
      expect(employeeActivation.requestTime, activationEntity.requestTime);

      verify(
        () => activationRepository.findByEmployeeId(employeeId: employeeId),
      ).called(1);

      verifyNoMoreInteractions(activationRepository);
    },
  );
}
