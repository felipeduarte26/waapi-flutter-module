import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/token_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_access_token_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/repositories/get_employees_to_facial_registration_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/usecases/get_employees_to_facial_registration_usecase.dart';

import '../../../../../mocks/pagination_employee_item_entity_mock.dart';

class MockGetEmployeesToFacialRegistrationRepository extends Mock
    implements GetEmployeesToFacialRegistrationRepository {}

class MockGetAccessTokenUsecase extends Mock implements GetAccessTokenUsecase {}

void main() {
  late GetEmployeesToFacialRegistrationRepository
      getEmployeesToFacialRegistrationRepository;
  late GetEmployeesToFacialRegistrationUsecase
      getEmployeesToFacialRegistrationUsecase;
  late GetAccessTokenUsecase getAccessTokenUsecase;

  setUpAll(() {
    getEmployeesToFacialRegistrationRepository =
        MockGetEmployeesToFacialRegistrationRepository();
    getAccessTokenUsecase = MockGetAccessTokenUsecase();

    getEmployeesToFacialRegistrationUsecase =
        GetEmployeesToFacialRegistrationUsecaseImpl(
      getEmployeesToFacialRegistrationRepository:
          getEmployeesToFacialRegistrationRepository,
      getAccessTokenUsecase: getAccessTokenUsecase,
    );
  });

  test(
    'should return true if person exists on facial recognition platform',
    () async {
      String? tokenApplication = 'accessToken';

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.user),
      ).thenAnswer((_) async => null);

      when(
        () => getAccessTokenUsecase.call(tokenType: TokenType.key),
      ).thenAnswer((_) async => tokenApplication);

      when(
        () => getEmployeesToFacialRegistrationRepository.call(
          pageNumber: 1,
          pageSize: 1,
          name: 'name',
          token: tokenApplication,
        ),
      ).thenAnswer(
        (_) async => paginationEmployeeItemEntityMock,
      );

      expect(
        await getEmployeesToFacialRegistrationUsecase.call(
          pageNumber: 1,
          pageSize: 1,
          name: 'name',
        ),
        paginationEmployeeItemEntityMock,
      );
    },
  );
}
