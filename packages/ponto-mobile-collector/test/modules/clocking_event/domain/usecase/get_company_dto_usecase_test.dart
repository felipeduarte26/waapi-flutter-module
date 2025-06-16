import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_company_dto_usecase.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../mocks/employee_entity_mock.dart';

class MockCompanyRepository extends Mock implements ICompanyRepository {}

void main() {
  const String tId = 'id';
  late IGetCompanyDtoUsecase getCompanyDtoUsecase;
  late ICompanyRepository companyRepository;

  setUp(
    () {
      companyRepository = MockCompanyRepository();
      getCompanyDtoUsecase =
          GetCompanyDtoUsecase(companyRepository: companyRepository);
    },
  );

  group(
    'GetCompanyDtoUsecase',
    () {
      test(
        'call test',
        () {
          when(
            () => companyRepository.findById(id: tId),
          ).thenAnswer((_) async => companyEntityMock);

          getCompanyDtoUsecase.call(id: tId);

          verify(
            () => companyRepository.findById(id: tId),
          ).called(1);

          verifyNoMoreInteractions(companyRepository);
        },
      );
    },
  );
}
