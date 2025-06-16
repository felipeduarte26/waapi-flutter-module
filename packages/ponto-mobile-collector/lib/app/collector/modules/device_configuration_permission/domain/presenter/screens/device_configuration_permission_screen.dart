import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../cubit/device_configuration_permission_cubit.dart';
import '../cubit/device_configuration_permission_state.dart';
import '../widgets/device_configuration_permission_row_widget.dart';

class DeviceConfigurationPermissionScreen extends StatefulWidget {
  final DeviceConfigurationPermissionCubit cubit;
  final NavigatorService navigatorService;

  const DeviceConfigurationPermissionScreen({
    required this.cubit,
    required this.navigatorService,
    super.key,
  });

  @override
  State<DeviceConfigurationPermissionScreen> createState() =>
      _DeviceConfigurationPermissionScreenState();
}

class _DeviceConfigurationPermissionScreenState
    extends State<DeviceConfigurationPermissionScreen>
    with SingleTickerProviderStateMixin {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    widget.cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        title: SeniorText.label(
          CollectorLocalizations.of(context).permissions,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.pureWhite,
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: SeniorColors.pureWhite,
          ),
          onPressed: () {
            widget.navigatorService.pop();
          },
        ),
        body: Column(
          children: [
            // Conteúdo principal
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SeniorSpacing.normal,
                    right: SeniorSpacing.normal,
                  ),
                  child: BlocConsumer<DeviceConfigurationPermissionCubit,
                      DeviceConfigurationPermissionBaseState>(
                    bloc: widget.cubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is ReadContentState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: SeniorSpacing.xsmall),
                            DeviceConfigurationPermissionRowWidget(
                              title: CollectorLocalizations.of(context)
                                  .cameraPermission,
                              description: CollectorLocalizations.of(context)
                                  .cameraPermissionDescription,
                              hasPermisssion: widget.cubit.hasCameraPermission,
                            ),
                            DeviceConfigurationPermissionRowWidget(
                              title: CollectorLocalizations.of(context)
                                  .gpsPermission,
                              description: CollectorLocalizations.of(context)
                                  .gpsPermissionDescription,
                              hasPermisssion: widget.cubit.hasGPSPermission,
                            ),
                            if (widget.cubit.isMulti) ...[
                              DeviceConfigurationPermissionRowWidget(
                                title: CollectorLocalizations.of(context)
                                    .nfcPermission,
                                description: CollectorLocalizations.of(context)
                                    .nfcPermissionDescription,
                                hasPermisssion: widget.cubit.hasNFCPermission,
                              ),
                            ],
                          ],
                        );
                      } else {
                        return LoadingWidget(
                          bottomLabel:
                              CollectorLocalizations.of(context).loading,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),

            // Botão fixo no rodapé
            Padding(
              padding: const EdgeInsets.all(SeniorSpacing.normal),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SeniorButton(
                    outlined: true,
                    label: CollectorLocalizations.of(context)
                        .deviceConfigurationPermission,
                    onPressed: () {
                      widget.cubit.openSystemAppSettings();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
