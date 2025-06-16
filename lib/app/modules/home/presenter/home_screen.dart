import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../core/extension/translate_extension.dart';
import '../../../core/services/has_clocking/presenter/bloc/has_clocking_state.dart';
import '../../../core/services/has_clocking_configuration/external/drivers/get_clocking_configuration_driver_impl.dart';
import '../../../core/services/has_clocking_configuration/external/get_clocking_configuration.dart';
import '../../../core/services/internal_storage/internal_storage_service.dart';
import '../../../core/services/rest_client/rest_service.dart';
import '../../../core/widgets/waapi_colorful_header.dart';
import '../../../core/widgets/waapi_loading_widget.dart';

import '../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../../happiness_index/presenter/blocs/happiness_index/happiness_index_state.dart';
import '../../management_panel/presenter/screens/management_panel/blocs/management_panel_screen/management_panel_screen_bloc.dart';
import '../../management_panel/presenter/screens/management_panel/management_panel_screen.dart';
import '../../management_panel/presenter/screens/management_panel/widgets/offline_widget.dart';
import '../controllers/home_connectivity_controller.dart';
import '../controllers/home_happiness_index_controller.dart';
import '../controllers/home_screen_listener_controller.dart';
import 'bloc/connectivity_bloc/connectivity_bloc.dart';
import 'bloc/connectivity_bloc/connectivity_state.dart';
import 'bloc/home_screen_bloc/home_screen_bloc.dart';
import 'bloc/home_screen_bloc/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  final Future<void> dataClockingFutureToBuild;

  const HomeScreen({
    super.key,
    required this.dataClockingFutureToBuild,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  static const MethodChannel _methodChannel = MethodChannel('flutter_to_react_native');
  late HomeConnectivityController _homeConnectivityController;
  late HomeScreenListenerController _homeScreenListenerController;
  late HomeHappinessIndexController _homeHappinessIndexController;
  late bool isOffline;
  late HomeScreenBloc homeScreenBloc;
  late ManagementPanelScreenBloc managementPanelScreenBloc;
  late AuthenticationBloc authenticationBloc;
  late bool clockingIsActive;
  int selectedIndex = 2;

  final List<Widget> _screens = [];
  final List<SeniorBottomNavigationBarItem> _bottomNavigationBarItems = [];

  late final RestService _restService;
  late final InternalStorageService _internalStorageService;

  bool showManagementPanel = false;
  bool showSocial = false;

  bool managementPanelIsInserted = false;
  bool socialIsInserted = false;
  bool allowGpoOnApp = false;

  @override
  void initState() {
    super.initState();
    clockingIsActive = false;
    homeScreenBloc = Modular.get<HomeScreenBloc>();
    _homeConnectivityController = HomeConnectivityController(
      homeScreenBloc: homeScreenBloc,
      getContext: () => context,
    );
    _homeScreenListenerController = HomeScreenListenerController(
      getContext: () => context,
      homeScreenBloc: homeScreenBloc,
      onSignOutChanged: ({required bool isSignOut}) {
        setState(() {});
        return isSignOut;
      },
    );
    _homeHappinessIndexController = HomeHappinessIndexController(
      happinessIndexBloc: homeScreenBloc.happinessIndexBloc,
      context: context,
    );

    isOffline = homeScreenBloc.state.connectivityState is OfflineConnectivityState;

    _restService = Modular.get<RestService>();
    _internalStorageService = Modular.get<InternalStorageService>();

    managementPanelScreenBloc = Modular.get<ManagementPanelScreenBloc>();
    authenticationBloc = Modular.get<AuthenticationBloc>();
    allowGpoOnApp = checkPermissionGpoOnApp();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _homeConnectivityController.dispose();
    super.dispose();
  }

  bool checkPermissionGpoOnApp() {
    final getClockingConfiguration = GetClockingConfiguration(
      restService: _restService,
      internalStorageService: _internalStorageService,
      getStoredTokenUsecase: GetStoredTokenUsecase(),
    );
    allowGpoOnApp = GetClockingConfigurationDriverImpl(internalStorageService: _internalStorageService)
            .call(key: getClockingConfiguration.keyAllowGpoOnApp) ??
        false;
    return allowGpoOnApp;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeScreenBloc, HomeScreenState>(
          bloc: homeScreenBloc,
          listener: (context, state) {
            final hasClockingState = state.hasClockingState;

            _homeScreenListenerController.handleHomeScreenState(
              context: context,
              authenticationState: state.authenticationState,
            );

            final connectivityState = state.connectivityState;
            isOffline = connectivityState is OfflineConnectivityState;

            final authorizationState = state.authorizationState;

            final showClockingOffline =
                hasClockingState is LoadedClockingState && hasClockingState.hasClocking && isOffline;

            if ((authorizationState is LoadedAuthorizationState &&
                    state.happinessIndexState is! LoadingHappinessIndexState) ||
                showClockingOffline) {
              if (authorizationState is LoadedAuthorizationState) {
                showManagementPanel = _homeScreenListenerController.isManagementPanelActive(
                      authorizationEntity: (state.authorizationState as LoadedAuthorizationState).authorizationEntity,
                    ) ||
                    (state.happinessIndexState is! HappinessIndexIsNotEnabledState) ||
                    authorizationState.authorizationEntity.allowToViewTimeManagement;

                showSocial = _homeScreenListenerController.isSocialActive(
                  socialAuthorizationEntity: (state.authorizationState as LoadedAuthorizationState)
                      .authorizationEntity
                      .socialAuthorizationEntity,
                );
              }

              showManagementPanel = showManagementPanel || showClockingOffline;

              if (showManagementPanel && !managementPanelIsInserted) {
                _screens.addAll([
                  const Text('Inicio'),
                  const Text('Holerite'),
                  ManagementPanelScreen(
                    dataClockingFutureToBuild: widget.dataClockingFutureToBuild,
                    hasPermission: showManagementPanel || allowGpoOnApp,
                    clockingIsActive: clockingIsActive,
                    managementPanelScreenBloc: managementPanelScreenBloc,
                    clockingIsActiveCall: ({required bool clockingIsActive}) {
                      clockingIsActive = clockingIsActive;
                      return clockingIsActive;
                    },
                    isWaapiLiteProfile: false,
                  ),
                  const Text('Mais'), 
                ]);
                _bottomNavigationBarItems.addAll([
                  const SeniorBottomNavigationBarItem(
                    icon: FontAwesomeIcons.solidHouse,
                    label: 'Início',
                    iconSize: SeniorSpacing.xmedium,
                    iconPadding: EdgeInsets.symmetric(
                      vertical: SeniorSpacing.xxsmall,
                    ),
                  ),
                  const SeniorBottomNavigationBarItem(
                    icon: FontAwesomeIcons.solidEnvelopeOpenDollar,
                    label: 'Holerite',
                    iconSize: SeniorSpacing.xmedium,
                    iconPadding: EdgeInsets.symmetric(
                      vertical: SeniorSpacing.xxsmall,
                    ),
                  ),
                  const SeniorBottomNavigationBarItem(
                    icon: FontAwesomeIcons.solidUsers,
                    label: 'Painel',
                    iconSize: SeniorSpacing.xmedium,
                    iconPadding: EdgeInsets.symmetric(
                      vertical: SeniorSpacing.xxsmall,
                    ),
                  ),
                  const SeniorBottomNavigationBarItem(
                    icon: FontAwesomeIcons.solidBars,
                    label: 'Mais',
                    iconSize: SeniorSpacing.xmedium,
                    iconPadding: EdgeInsets.symmetric(
                      vertical: SeniorSpacing.xxsmall,
                    ),
                  ),
                ]);
                managementPanelIsInserted = true;
              }
            }
          },
        ),
        BlocListener<ConnectivityBloc, ConnectivityState>(
          bloc: homeScreenBloc.connectivityBloc,
          listenWhen: (oldState, newState) => oldState != newState,
          listener: (context, state) {
            _homeConnectivityController.handleConnectivityState(
              homeConnectivityState: state,
            );
          },
        ),
        BlocListener<HappinessIndexBloc, HappinessIndexState>(
          bloc: homeScreenBloc.happinessIndexBloc,
          listenWhen: (oldState, newState) => oldState != newState,
          listener: (context, state) {
            _homeHappinessIndexController.handleHappinessIndexState(
              state: state,
            );
          },
        ),
      ],
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
        bloc: homeScreenBloc,
        builder: (context, state) {
          if (!showManagementPanel && !showSocial && !isOffline) {
            return Scaffold(
              body: WaapiColorfulHeader(
                hasTopPadding: false,
                title: SeniorText.label(
                  color: SeniorColors.pureWhite,
                  darkColor: SeniorColors.grayscale5,
                  context.translate.appTitle,
                ),
                hideLeading: true,
                body: const Center(
                  child: WaapiLoadingWidget(),
                ),
              ),
            );
          }

          if (!showManagementPanel && !showSocial && isOffline) {
            return Scaffold(
              body: WaapiColorfulHeader(
                title: SeniorText.label(
                  color: SeniorColors.pureWhite,
                  darkColor: SeniorColors.grayscale5,
                  context.translate.appTitle,
                ),
                hideLeading: true,
                body: const OfflineWidget(),
              ),
            );
          }

          if (showManagementPanel || showSocial) {
            return PopScope(
              canPop: false,
              child: Scaffold(
                body: IndexedStack(
                  index: selectedIndex,
                  children: _screens,
                ),
                bottomNavigationBar: _screens.length > 1
                    ? SeniorBottomNavigationBar(
                        style: const SeniorBottomNavigationBarStyle(
                          selectedItemColor: Color(0xFF5734DA),
                          unselectedItemColor: Color(0xFF4D5767),
                          color: SeniorColors.pureWhite,
                        ),
                        currentIndex: selectedIndex,
                        items: _bottomNavigationBarItems,
                        onTap: (index) async {
                          setState(() {});
                          String reactNativeScreen = '';
                          if (index == 0) {
                            reactNativeScreen = 'NewHome';
                          } else if (index == 1) {
                            reactNativeScreen = 'Payslip';
                          } else if (index == 3) {
                            reactNativeScreen = 'More';
                          }

                          if (reactNativeScreen.isNotEmpty) {
                            log('ReactNative  screen is not empty');
                            try {
                              await _methodChannel.invokeMethod(
                                'navigateTo',
                                {'screen': reactNativeScreen},
                              );
                            } on PlatformException catch (e) {
                              log(
                                'Erro ao navegar para o React Native: ${e.message}',
                              );
                            }
                          }
                        },
                      )
                    : null,
              ),
            );
          }

          return WaapiColorfulHeader(
            hasTopPadding: false,
            title: SeniorText.label(
              color: SeniorColors.pureWhite,
              darkColor: SeniorColors.grayscale5,
              context.translate.appTitle,
            ),
            hideLeading: true,
            body: const Center(
              child: WaapiLoadingWidget(),
            ),
          );
        },
      ),
    );
  }
}
