import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/authenticate_registered_key_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/failed_authentication_key_cubit/failed_authentication_key_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/application_key/presenter/cubit/failed_authentication_key_cubit/failed_authentication_key_state.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/application_key_routes.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';

class MockAuthenticateRegisteredKeyUsecase extends Mock
    implements AuthenticateRegisteredKeyUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

void main() {
  late FailedAuthenticationKeyCubit failedAuthenticationKeyCubit;
  late AuthenticateRegisteredKeyUsecase authenticateRegisteredKeyUsecase;
  late NavigatorService navigatorService;
  late HasConnectivityUsecase hasConnectivityUsecase;

  setUp(() {
    authenticateRegisteredKeyUsecase = MockAuthenticateRegisteredKeyUsecase();
    navigatorService = MockNavigatorService();
    hasConnectivityUsecase = MockHasConnectivityUsecase();

    when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

    failedAuthenticationKeyCubit = FailedAuthenticationKeyCubit(
      authenticateRegisteredKeyUsecase: authenticateRegisteredKeyUsecase,
      navigatorService: navigatorService,
      hasConnectivityUsecase: hasConnectivityUsecase,
    );
  });

  group('FailedAuthenticationKeyCubit', () {
    blocTest(
      'offline authenticateKey test',
      setUp: () {
        when(() => hasConnectivityUsecase.call())
            .thenAnswer((_) async => false);
      },
      build: () => failedAuthenticationKeyCubit,
      act: (cubit) => cubit.authenticateKey(),
      expect: () => [
        isA<AuthenticatingFailedAuthenticationKeyState>(),
        isA<NoConnectionFailedAuthenticationKeyState>(),
        isA<ReadyFailedAuthenticationKeyState>(),
      ],
      verify: (bloc) {
        verify(() => hasConnectivityUsecase.call());
        verifyNoMoreInteractions(hasConnectivityUsecase);
      },
    );

    blocTest(
      'online error authentication test',
      setUp: () {
        when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

        when(() => authenticateRegisteredKeyUsecase.call())
            .thenAnswer((_) async => false);
      },
      build: () => failedAuthenticationKeyCubit,
      act: (cubit) => cubit.authenticateKey(),
      expect: () => [
        isA<AuthenticatingFailedAuthenticationKeyState>(),
        isA<FailureFailedAuthenticationKeyState>(),
        isA<ReadyFailedAuthenticationKeyState>(),
      ],
      verify: (bloc) {
        verify(() => hasConnectivityUsecase.call());
        verify(() => authenticateRegisteredKeyUsecase.call());
        verifyNoMoreInteractions(hasConnectivityUsecase);
        verifyNoMoreInteractions(authenticateRegisteredKeyUsecase);
      },
    );

    blocTest(
      'online success authentication test',
      setUp: () {
        when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

        when(() => authenticateRegisteredKeyUsecase.call())
            .thenAnswer((_) async => true);

        when(
          () => navigatorService.navigate(
            route: PontoMobileCollectorRoutes.appStartupHome,
          ),
        ).thenAnswer((_) async => {});
      },
      build: () => failedAuthenticationKeyCubit,
      act: (cubit) => cubit.authenticateKey(),
      expect: () => [
        isA<AuthenticatingFailedAuthenticationKeyState>(),
      ],
      verify: (bloc) {
        verify(() => hasConnectivityUsecase.call());
        verify(() => authenticateRegisteredKeyUsecase.call());
        verify(
          () => navigatorService.navigate(
            route: PontoMobileCollectorRoutes.appStartupHome,
          ),
        );
        verifyNoMoreInteractions(hasConnectivityUsecase);
        verifyNoMoreInteractions(authenticateRegisteredKeyUsecase);
        verifyNoMoreInteractions(navigatorService);
      },
    );

    blocTest(
      'offline navigateToRegisterKey test',
      setUp: () {
        when(() => hasConnectivityUsecase.call())
            .thenAnswer((_) async => false);
      },
      build: () => failedAuthenticationKeyCubit,
      act: (cubit) => cubit.navigateToRegisterKey(),
      expect: () => [
        isA<NoConnectionFailedAuthenticationKeyState>(),
        isA<ReadyFailedAuthenticationKeyState>(),
      ],
      verify: (bloc) {
        verify(() => hasConnectivityUsecase.call());
        verifyNoMoreInteractions(hasConnectivityUsecase);
      },
    );

    blocTest(
      'online navigateToRegisterKey test',
      setUp: () {
        when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

        when(
          () => navigatorService.pushNamed(
            route: ApplicationKeyRoutes.registerKeyFull,
          ),
        ).thenAnswer((_) async => {});
      },
      build: () => failedAuthenticationKeyCubit,
      act: (cubit) => cubit.navigateToRegisterKey(),
      verify: (bloc) {
        verify(() => hasConnectivityUsecase.call());
        verify(
          () => navigatorService.pushNamed(
            route: ApplicationKeyRoutes.registerKeyFull,
          ),
        );
        verifyNoMoreInteractions(hasConnectivityUsecase);
        verifyNoMoreInteractions(navigatorService);
      },
    );

    blocTest(
      'closeApplication test',
      setUp: () {
        when(
          () => navigatorService.closeApplication(),
        ).thenAnswer((_) async => {});
      },
      build: () => failedAuthenticationKeyCubit,
      act: (cubit) => cubit.closeApplication(),
      verify: (bloc) {
        verify(
          () => navigatorService.closeApplication(),
        );
        verifyNoMoreInteractions(navigatorService);
      },
    );
  });
}
