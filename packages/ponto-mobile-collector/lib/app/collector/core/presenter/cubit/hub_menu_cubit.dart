import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../modules/routes/collector_routes.dart';
import '../../../modules/routes/time_adjustment_routes.dart';
import '../../domain/entities/hub_menu_entity.dart';
import '../../domain/services/firebase/log_service.dart';
import '../../domain/services/navigator/navigator_service.dart';
import '../../domain/usecases/get_execution_mode_usecase.dart';
import '../../domain/usecases/get_platform_menus_usecase.dart';
import '../../infra/services/shared_preferences/shared_preferences_service.dart';
import '../../infra/utils/enum/execution_mode_enum.dart';
import '../../infra/utils/enum/user_action_enum.dart';
import '../../infra/utils/enum/user_resource_enum.dart';

class HubMenuCubit extends Cubit<BuildMenuState> {
  final List<HubMenuEntity> _hubMenuEntities = [];
  final GetPlatformMenusUsecase platformMenusUsecase;
  final SharedPreferencesService sharedPreferencesService;
  final GetExecutionModeUsecase getExecutionModeUsecase;
  final NavigatorService navigatorService;
  final LogService _logService;

  HubMenuCubit(
    this.platformMenusUsecase,
    this.sharedPreferencesService,
    this.getExecutionModeUsecase,
    this.navigatorService,
    this._logService,
  ) : super(InitialMenuState());

  int getTotalItems() {
    return _hubMenuEntities.length;
  }

  HubMenuEntity getHubMenuEntity(int index) {
    return _hubMenuEntities[index];
  }

  void addItem(HubMenuEntity hubMenuEntity) {
    _hubMenuEntities.add(hubMenuEntity);
    emit(MenuChangedState());
  }

  Future<void> addPlatformMenus({
    required String driverTitle,
    required String timeAdjustmentTitle,
  }) async {
    _hubMenuEntities.clear();
    ExecutionModeEnum executionModeEnum = await getExecutionModeUsecase.call();

    if (executionModeEnum.isDriver()) {
      HubMenuEntity driverMenu = HubMenuEntity(
        iconData: FontAwesomeIcons.truck,
        onTap: () {
          navigatorService.pushNamed(
            route: '/${PontoMobileCollectorRoutes.driversJourney}',
          );
        },
        title: driverTitle,
      );

      _hubMenuEntities.add(driverMenu);
    }

    addClockingEventMenu(timeAdjustmentTitle);

    emit(MenuChangedState());

    List<HubMenuEntity>? hubMenuEntities = await platformMenusUsecase.call();

    if (hubMenuEntities != null) {
      _hubMenuEntities.addAll(hubMenuEntities);
      emit(MenuChangedState());
    }
  }

  Future<void> addClockingEventMenu(title) async {
    String? userName = await sharedPreferencesService.getSessionPlatformUsername();

    bool employeePermission = await sharedPreferencesService.getUserPermission(
      userName: userName.toString(),
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.employee.resource,
    );

    if (employeePermission) {
      var hubMenuEntity = HubMenuEntity(
        iconData: FontAwesomeIcons.calendarDays,
        onTap: () {
          _logService.saveLocalLog(exception: 'TraceRouteLog', stackTrace: 'Access view TimeAdjustmentRoutes.homeFull', dateTimeOnDevice: DateTime.now());
          Modular.to.pushNamed(TimeAdjustmentRoutes.homeFull);
        },
        title: title,
      );

      _hubMenuEntities.add(hubMenuEntity);
      emit(MenuChangedState());
    }
  }
}

abstract class BuildMenuState {}

class InitialMenuState extends BuildMenuState {}

class MenuChangedState extends BuildMenuState {}
