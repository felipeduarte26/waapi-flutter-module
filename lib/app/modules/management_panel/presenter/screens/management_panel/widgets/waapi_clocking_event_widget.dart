import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../../core/environment/environment_variables.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/icon_header_widget.dart';
import '../../../../../../core/widgets/state_card_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/authentication_routes.dart';
import '../../../../../../routes/home_routes.dart';

class WaapiClockingEventWidget extends StatefulWidget {
  final Future<void> dataClockingFutureToBuild;
  const WaapiClockingEventWidget({
    super.key,
    required this.onStatusChanged,
    required this.dataClockingFutureToBuild,
  });

  final ValueChanged<bool> onStatusChanged;

  @override
  State<WaapiClockingEventWidget> createState() {
    return _WaapiClockingEventWidgetState();
  }
}

class _WaapiClockingEventWidgetState extends State<WaapiClockingEventWidget> {
  late Future<void> dataClockingFuture;

  @override
  void initState() {
    super.initState();
    dataClockingFuture = widget.dataClockingFutureToBuild;
  }

  Future<void> initClockModule() async {
    await Modular.get<ICollectorModuleService>().initialize(
      homePath: HomeRoutes.homeScreenInitialRoute,
      environment: EnvironmentVariables.environmentClockModuleEnum,
      appIdentifier: AppIdentfierEnum.waapi,
      hideBackButton: false,
      showNotificationButton: false,
      loginPath: AuthenticationRoutes.authenticationModuleRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: IconHeaderWidget(
                key: const Key('management-Panel_screen-description_clocking_event'),
                title: context.translate.clockingEventTitle,
                icon: FontAwesomeIcons.solidClock,
                removeBottomPadding: true,
              ),
            ),
          ],
        ),
        FutureBuilder(
          future: dataClockingFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: SeniorSpacing.medium,
                  ),
                  child: WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              widget.onStatusChanged(false);
              return Center(
                child: StateCardWidget(
                  margin: const EdgeInsets.all(
                    SeniorSpacing.normal,
                  ),
                  showButton: true,
                  onTap: () {
                    setState(() {
                      dataClockingFuture = initClockModule();
                    });
                  },
                  message: context.translate.genericErrorAndTryAgain,
                  iconData: FontAwesomeIcons.solidTriangleExclamation,
                  disabled: false,
                ),
              );
            } else {
              widget.onStatusChanged(true);

              return ClockingEventWidget(
                navigatorService: Modular.get(),
                clockingEventBloc: Modular.get(),
                clockingEventUtil: Modular.get(),
                workIndicatorCubit: Modular.get(),
                registerClockingEventBloc: Modular.get(),
                showBottomSheetUsecase: Modular.get(),
                timerBloc: Modular.get(),
                facialRegistrationMessageWidget: FacialRegistrationMessageWidget(
                  context: context,
                  navigatorService: Modular.get(),
                  showFaceRegistrationMessageUsecase: Modular.get(),
                ),
                confirmationSnackbarWidget: ConfirmationSnackbarWidget(
                  utils: Modular.get(),
                  getReceiptUsecase: Modular.get(),
                  context: context,
                  showBottomSheetUsecase: Modular.get(),
                ),
                getLifecycleStreamUsecase: Modular.get(),
                errorBuilder: (message, description) {
                  return StateCardWidget(
                    margin: const EdgeInsets.all(
                      SeniorSpacing.normal,
                    ),
                    message: message,
                    descriptionMessage: description,
                    iconData: FontAwesomeIcons.solidTriangleExclamation,
                    disabled: false,
                  );
                },
                platformService: Modular.get(),
              );
            }
          },
        ),
      ],
    );
  }
}
