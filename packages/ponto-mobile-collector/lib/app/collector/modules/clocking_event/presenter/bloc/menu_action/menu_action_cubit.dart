import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/components/components.dart';

import '../../../../../core/domain/entities/hub_menu_entity.dart';
import '../../../../../core/domain/services/configuration/icollector_module_service.dart';
import '../../../../../core/domain/services/platform/iplatform_service.dart';
import '../../../../../core/domain/usecases/get_platform_menus_usecase.dart';
import '../../../../../core/infra/utils/enum/app_identifier_enum.dart';

class MenuActionCubit extends Cubit<MenuActionCubitState> {
  final GetPlatformMenusUsecase _getPlatformMenusUsecase;
  final ICollectorModuleService _collectorModuleService;
  final IPlatformService _platformService;
  StreamSubscription<bool>? _connectivitySubscription;

  bool showMenu = true;
  List<SeniorSquareButtonsMenuItemData> squareButtonsMenuItemData = [];

  MenuActionCubit({
    required GetPlatformMenusUsecase getPlatformMenusUsecase,
    required ICollectorModuleService collectorModuleService,
    required IPlatformService platformService,
  })  : _getPlatformMenusUsecase = getPlatformMenusUsecase,
        _collectorModuleService = collectorModuleService,
        _platformService = platformService,
        super(InitialMenuActionCubitState()) {
    _connectivitySubscription =
        _platformService.connectivityStream().listen((event) {
      loadPlatformMenus();
    });
    showMenu =
        _collectorModuleService.getAppIdentfierEnum() == AppIdentfierEnum.ponto;
    loadPlatformMenus();
  }

  Future<void> loadPlatformMenus() async {
    log('MenuActionCubit: Carregando menus de acesso ao GPO');
    squareButtonsMenuItemData = [];
    if (await _platformService.hasConnectivity()) {
      List<HubMenuEntity>? hubMenuEntities;

      try {
        hubMenuEntities = await _getPlatformMenusUsecase.call();
      } catch (e) {
        log('MenuActionCubit: Erro ao carregar menus de acesso ao GPO.');
      }

      if (hubMenuEntities != null && hubMenuEntities.isNotEmpty) {
        for (var element in hubMenuEntities) {
          squareButtonsMenuItemData.add(
            SeniorSquareButtonsMenuItemData(
              onTap: element.onTap,
              icon: element.iconData,
              text: element.title,
              type: SeniorSquareButtonsMenuItemType.neutral,
            ),
          );
        }
      }
    }

    emit(ReadyMenuActionCubitState());
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
  }
}

abstract class MenuActionCubitState {}

class InitialMenuActionCubitState extends MenuActionCubitState {}

class ReadyMenuActionCubitState extends MenuActionCubitState {}
