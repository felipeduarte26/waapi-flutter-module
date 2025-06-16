import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/entities/has_unread_push_message_entity.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/domain/usecases/get_number_unread_notifications_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/counter_notifications_bloc/counter_notifications_bloc.dart';
import 'package:ponto_mobile_collector/app/collector/modules/notification/presenter/blocs/counter_notifications_bloc/counter_notifications_state.dart';

class GetNumberUnreadNotificationsUsecaseMock extends Mock
    implements GetNumberUnreadNotificationsUsecase {}

class MockHasConnectivityUsecase extends Mock
  implements IHasConnectivityUsecase {}

void main() {
  late GetNumberUnreadNotificationsUsecase
      getNumberUnreadNotificationsUsecaseMock;
  late HasUnreadPushMessageEntity hasUnreadPushMessageEntity;
  late IHasConnectivityUsecase hasConnectivityUsecase;

  setUp(() {
    getNumberUnreadNotificationsUsecaseMock =
        GetNumberUnreadNotificationsUsecaseMock();
    hasUnreadPushMessageEntity = HasUnreadPushMessageEntity(
      hasUnreadPushMessage: true,
      number: 2,
    );
    hasConnectivityUsecase = MockHasConnectivityUsecase();

    when(
      () => getNumberUnreadNotificationsUsecaseMock.call(),
    ).thenAnswer(
      (_) async => hasUnreadPushMessageEntity,
    );
  });

  group(
    'CounterNotificationsBlocTest',
    () {
      blocTest<CounterNotificationsBloc, CounterNotificationsState>(
        'Should emit [LoadingCounterNotificationsState, SucceedCounterNotificationsState] when usecase returns entity',
        build: () {
          return CounterNotificationsBloc(
            getNumberUnreadNotificationsUsecase:
                getNumberUnreadNotificationsUsecaseMock,
            hasConnectivityUsecase: hasConnectivityUsecase,
          );
        },
        act: (bloc) {},
        expect: () {
          return [
            LoadingCounterNotificationsState(),
            SucceedCounterNotificationsState(
              hasUnreadPushMessage: hasUnreadPushMessageEntity,
            ),
          ];
        },
      );
    },
  );
}
