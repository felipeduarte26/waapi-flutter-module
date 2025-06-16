import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/types/either.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_notification_dto.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/repositories/push_notifications_repository.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/get_list_recent_notifications_usecase.dart';

class MockPushNotificationsRepository extends Mock
    implements PushNotificationsRepository {}

void main() {
  late GetListRecentNotificationsUseCaseImpl useCase;
  late MockPushNotificationsRepository mockRepository;

  setUp(() {
    mockRepository = MockPushNotificationsRepository();
    useCase = GetListRecentNotificationsUseCaseImpl(
        pushNotificationsRepository: mockRepository,);
  });

  group('GetListRecentNotificationsUseCaseImpl', () {
    const employeeId = 'test_employee_id';
    final pushNotificationDto = PushNotificationDto(messages: []);

    test('should return recent notifications when the call is successful',
        () async {
      // Arrange
      final response = right<NotificationFailure, PushNotificationDto>(pushNotificationDto);

      when(() => mockRepository.call(employeeId: employeeId))
          .thenAnswer((_) async => response);

      // Act
      final result = await useCase.call(employeeId: employeeId);

      // Assert
      expect(result, response);
      verify(() => mockRepository.call(employeeId: employeeId))
          .called(1);
    });

    test('should return a failure when the repository call fails', () async {
      // Arrange
      final response = left<NotificationFailure, PushNotificationDto>(const NotificationDatasourceFailure());

      when(() => mockRepository.call(employeeId: employeeId))
          .thenAnswer((_) async => response);

      // Act
      final result = await useCase.call(employeeId: employeeId);

      // Assert
      expect(result, response);
      verify(() => mockRepository.call(employeeId: employeeId))
          .called(1);
    });
  });
}
