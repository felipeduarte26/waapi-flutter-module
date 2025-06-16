import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/hub_menu_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_platform_menus_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/menu_action/menu_action_cubit.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

class MockGetPlatformMenusUsecase extends Mock
    implements GetPlatformMenusUsecase {}

class MockICollectorModuleService extends Mock
    implements ICollectorModuleService {}

class MockPlatformService extends Mock implements IPlatformService {}

void main() {
  late MenuActionCubit menuActionCubit;
  late GetPlatformMenusUsecase getPlatformMenusUsecase;
  late ICollectorModuleService collectorModuleService;
  late IPlatformService platformService;

  setUp(() {
    getPlatformMenusUsecase = MockGetPlatformMenusUsecase();
    collectorModuleService = MockICollectorModuleService();
    platformService = MockPlatformService();

    when(
      () => collectorModuleService.getAppIdentfierEnum(),
    ).thenReturn(
      AppIdentfierEnum.ponto,
    );

    when(
      () => getPlatformMenusUsecase.call(),
    ).thenAnswer((_) async => []);

    when(
      () => platformService.hasConnectivity(),
    ).thenAnswer((_) async => true);

    when(
      () => platformService.connectivityStream(),
    ).thenAnswer((_) => const Stream.empty());

    menuActionCubit = MenuActionCubit(
      getPlatformMenusUsecase: getPlatformMenusUsecase,
      collectorModuleService: collectorModuleService,
      platformService: platformService,
    );
  });

  tearDown(() async {
    await menuActionCubit.dispose();
  });

  group('MenuActionCubit', () {
    blocTest<MenuActionCubit, MenuActionCubitState>(
      'load empty menus test',
      build: () => menuActionCubit,
      act: (bloc) => bloc.loadPlatformMenus(),
      expect: () => [
        isA<ReadyMenuActionCubitState>(),
      ],
      verify: (bloc) {
        verify(() => collectorModuleService.getAppIdentfierEnum());
        verify(() => getPlatformMenusUsecase.call());
      },
    );

    blocTest<MenuActionCubit, MenuActionCubitState>(
      'load menus test',
      setUp: () {
        when(
          () => getPlatformMenusUsecase.call(),
        ).thenAnswer(
          (_) async => [
            HubMenuEntity(
              onTap: () => {},
              title: 'title',
              iconData: FontAwesomeIcons.solidCalendarDays,
            ),
          ],
        );
      },
      build: () => menuActionCubit,
      act: (bloc) => bloc.loadPlatformMenus(),
      expect: () => [
        isA<ReadyMenuActionCubitState>(),
      ],
      verify: (bloc) {
        verify(() => collectorModuleService.getAppIdentfierEnum());
        verify(() => getPlatformMenusUsecase.call());
      },
    );

    blocTest<MenuActionCubit, MenuActionCubitState>(
      'error loading menu test',
      setUp: () {
        when(
          () => getPlatformMenusUsecase.call(),
        ).thenThrow(
          Exception(),
        );
      },
      build: () => menuActionCubit,
      act: (bloc) => bloc.loadPlatformMenus(),
      expect: () => [
        isA<ReadyMenuActionCubitState>(),
      ],
      verify: (bloc) {
        verify(() => collectorModuleService.getAppIdentfierEnum());
        verify(() => getPlatformMenusUsecase.call());
      },
    );

    test('change connectivity test', () async {
      StreamController<bool> connectivityController = StreamController<bool>();

      when(
        () => platformService.connectivityStream(),
      ).thenAnswer((_) => connectivityController.stream);

      connectivityController.add(false);
      await Future.delayed(const Duration(milliseconds: 100));
      verify(() => collectorModuleService.getAppIdentfierEnum());
      verify(() => getPlatformMenusUsecase.call());
    });
  });
}
