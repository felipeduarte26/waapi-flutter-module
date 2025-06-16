import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/employee_dto.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/types/either.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/push_notification_dto.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/failures/notification_failure.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/get_list_recent_notifications_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_event.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/list_notifications_bloc/list_notifications_state.dart';

import '../../../../../mocks/clock_company_dto_mock.dart';

class MockGetListRecentNotificationsUseCase extends Mock
    implements GetListRecentNotificationsUseCase {}

class MockIHasConnectivityUsecase extends Mock
    implements IHasConnectivityUsecase {}

class MockIGetEmployeeUsecase extends Mock implements IGetEmployeeUsecase {}

void main() {
  late ListNotificationsBloc bloc;
  late MockGetListRecentNotificationsUseCase
      mockGetListRecentNotificationsUseCase;
  late MockIHasConnectivityUsecase mockIHasConnectivityUsecase;
  late MockIGetEmployeeUsecase mockIGetEmployeeUsecase;

  late PushNotificationDto pushNotificationDto;
  late PushMessageEntity pushMessageEntity;

  setUp(() {
    mockGetListRecentNotificationsUseCase =
        MockGetListRecentNotificationsUseCase();
    mockIHasConnectivityUsecase = MockIHasConnectivityUsecase();
    mockIGetEmployeeUsecase = MockIGetEmployeeUsecase();

    bloc = ListNotificationsBloc(
      getListRecentNotificationsUseCase: mockGetListRecentNotificationsUseCase,
      hasConnectivityUsecase: mockIHasConnectivityUsecase,
      getEmployeeUsecase: mockIGetEmployeeUsecase,
    );

    pushNotificationDto = PushNotificationDto(
      messages: [
        PushMessageEntity(
          id: '1',
          title: 'Test',
          messageContent: 'Test',
          createdAt: DateTime.now(),
        ),
      ],
    );

    pushMessageEntity = PushMessageEntity(
      id: '1',
      title: 'Test',
      messageContent: 'Test',
      createdAt: DateTime.now(),
      read: false,
    );

    when(() => mockIHasConnectivityUsecase.call())
        .thenAnswer((_) async => true);

    when(() => mockIGetEmployeeUsecase.call()).thenAnswer(
      (_) => EmployeeDto(
        id: 'employeeId',
        employeeType: 'TESTE',
        cpfNumber: 'TESTE',
        company: companyDtoMock,
        name: 'TESTE',
      ),
    );
  });

  group('ListNotificationsBloc', () {
    test('initial state is InitialListNotificationsState', () {
      expect(bloc.state, equals(InitialListNotificationsState()));
    });

    blocTest<ListNotificationsBloc, ListNotificationsState>(
      'emits [LoadingListNotificationsState, LoadedListNotificationsState] when GetListRecentNotificationsEvent is added',
      build: () {
        when(
          () => mockGetListRecentNotificationsUseCase.call(
            employeeId: any(named: 'employeeId'),
          ),
        ).thenAnswer(
          (_) async => right(
            pushNotificationDto,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetListRecentNotificationsEvent()),
      expect: () => [
        LoadingListNotificationsState(),
        LoadedListNotificationsState(
          notifications: pushNotificationDto.messages,
        ),
      ],
    );

    blocTest<ListNotificationsBloc, ListNotificationsState>(
      'emits [LoadingListNotificationsState, ErrorListNotificationsState] when GetListRecentNotificationsEvent fails',
      build: () {
        when(
          () => mockGetListRecentNotificationsUseCase.call(
            employeeId: any(named: 'employeeId'),
          ),
        ).thenAnswer(
          (_) async => left(const NotificationDatasourceFailure()),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetListRecentNotificationsEvent()),
      expect: () => [
        LoadingListNotificationsState(),
        isA<ErrorListNotificationsState>(),
      ],
    );

    blocTest<ListNotificationsBloc, ListNotificationsState>(
      'emits [LoadingListNotificationsState, ErrorListNotificationsState] when GetListRecentNotificationsEvent fails',
      build: () {
        when(() => mockIHasConnectivityUsecase.call())
            .thenAnswer((_) async => false);

        return bloc;
      },
      act: (bloc) => bloc.add(GetListRecentNotificationsEvent()),
      expect: () => [
        LoadingListNotificationsState(),
        isA<ErrorListNotificationsState>(),
      ],
    );

    blocTest<ListNotificationsBloc, ListNotificationsState>(
      'emits [LoadingListNotificationsState, EmptyListNotificationsState] when GetListRecentNotificationsEvent fails',
      build: () {
        when(() => mockIGetEmployeeUsecase.call()).thenAnswer(
          (_) => null,
        );

        return bloc;
      },
      act: (bloc) => bloc.add(GetListRecentNotificationsEvent()),
      expect: () => [
        LoadingListNotificationsState(),
        isA<EmptyListNotificationsState>(),
      ],
    );
  });

  group('_changeNotificationToReadEvent', () {
    blocTest<ListNotificationsBloc, ListNotificationsState>(
      'emits [LoadingListNotificationsState, LoadedListNotificationsState] when ChangeNotificationToReadScreenEvent is added',
      build: () {
        return bloc;
      },
      act: (bloc) {
        bloc.emit(
          LoadedListNotificationsState(
            notifications: [
              pushMessageEntity,
            ],
          ),
        );
        bloc.add(ChangeNotificationToReadScreenEvent(notificationIndex: 0));
      },
      expect: () => [
        isA<LoadedListNotificationsState>(),
        isA<LoadingListNotificationsState>(),
        predicate<LoadedListNotificationsState>((state) {
          return state.notifications.length == 1 &&
              state.notifications.first.read == true;
        }),
      ],
    );
  });
}
