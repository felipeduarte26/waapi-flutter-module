
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/types/either.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/repositories/get_number_unread_notifications_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/get_number_unread_notifications_usecase.dart';

import '../../../../mocks/clock_company_dto_mock.dart';


class MockGetNumberUnreadNotificationsRepository extends Mock
    implements GetNumberUnreadNotificationsRepository {}

class MockIGetEmployeeUsecase extends Mock implements IGetEmployeeUsecase {}

void main() {
  late GetNumberUnreadNotificationsUsecaseImpl usecase;
  late MockGetNumberUnreadNotificationsRepository mockRepository;
  late MockIGetEmployeeUsecase mockGetEmployeeUsecase;

  setUp(() {
    mockRepository = MockGetNumberUnreadNotificationsRepository();
    mockGetEmployeeUsecase = MockIGetEmployeeUsecase();
    usecase = GetNumberUnreadNotificationsUsecaseImpl(
      getNumberUnreadNotificationsRepository: mockRepository,
      getEmployeeUsecase: mockGetEmployeeUsecase,
    );
  });

  group('GetNumberUnreadNotificationsUsecaseImpl', () {
    EmployeeDto employee = EmployeeDto(
      id: 'test_employee',
      employeeType: '',
      cpfNumber: '',
      company: companyDtoMock, name: '',
    );
    final hasUnreadPushMessageEntity =
        HasUnreadPushMessageEntity(hasUnreadPushMessage: true, number: 2);

    test(
        'should return HasUnreadPushMessageEntity when repository call is successful',
        () async {
      // Arrange

      when(() => mockGetEmployeeUsecase.call()).thenAnswer((_) => employee);
      when(
        () => mockRepository.call(
          employeeId: employee.id,
        ),
      ).thenAnswer(
        (_) async => right<NotificationFailure, HasUnreadPushMessageEntity>(
          hasUnreadPushMessageEntity,
        ),
      );

      // Act
      final result = await usecase.call();

      // Assert
      expect(
        result.hasUnreadPushMessage,
        true,
      );
      expect(
        result.number,
        2,
      );

      verify(() => mockGetEmployeeUsecase.call()).called(1);
      verify(
        () => mockRepository.call(
          employeeId: employee.id,
        ),
      ).called(1);
    });

    test('should return NotificationFailure when repository call fails',
        () async {
      // Arrange
      when(() => mockGetEmployeeUsecase.call()).thenAnswer((_) => employee);
      when(
        () => mockRepository.call(
          employeeId: employee.id,
        ),
      ).thenAnswer(
        (_) async => left<NotificationFailure, HasUnreadPushMessageEntity>(
          const NotificationDatasourceFailure(),
        ),
      );

      // Act
      final result = await usecase.call();

      // Assert
      expect(
        result.hasUnreadPushMessage,
        false,
      );
      verify(() => mockGetEmployeeUsecase.call()).called(1);
      verify(
        () => mockRepository.call(
          employeeId: employee.id,
        ),
      ).called(1);
    });
  });
}
