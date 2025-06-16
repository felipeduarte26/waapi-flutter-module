import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../modules/routes/time_adjustment_routes.dart';
import '../../domain/entities/hub_menu_entity.dart';
import '../cubit/hub_menu_cubit.dart';
import '../widgets/hub_menu/hub_menu_widget.dart';

class HubClockingPage extends StatefulWidget {
  final HubMenuCubit _hubMenuCubit;
  final BuildContext _context;

  const HubClockingPage({
    super.key,
    required HubMenuCubit hubMenuCubit,
    required BuildContext context,
  })  : _hubMenuCubit = hubMenuCubit,
        _context = context;

  @override
  State<HubClockingPage> createState() => _HubClockingPageState();
}

class _HubClockingPageState extends State<HubClockingPage> {
  @override
  void initState() {
    HubMenuEntity(
      iconData: FontAwesomeIcons.calendarDays,
      onTap: () {
        Modular.to.pushNamed(TimeAdjustmentRoutes.homeFull);
      },
      title: CollectorLocalizations.of(widget._context).clockingEvents,
    );

    widget._hubMenuCubit.addPlatformMenus(
      driverTitle: CollectorLocalizations.of(widget._context).driversJourney,
      timeAdjustmentTitle: CollectorLocalizations.of(widget._context).clockingEvents,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    final isDark = themeRepository.isDarkTheme();
    final isCustom = themeRepository.isCustomTheme();

    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: isCustom
                ? SeniorServiceColor.getOptimalContrastColorTheme(
                    color: themeRepository.theme.secondaryColor ?? SeniorColors.primaryColor,
                  )
                : isDark
                    ? SeniorColors.grayscale5
                    : SeniorColors.pureWhite,
          ),
          iconSize: SeniorSpacing.small,
          onPressed: () => Modular.to.pop(),
        ),
        title: SeniorText.label(
          CollectorLocalizations.of(context).timeControlManagement,
          color: isCustom
              ? SeniorServiceColor.getOptimalContrastColorTheme(
                  color: themeRepository.theme.secondaryColor ?? SeniorColors.primaryColor,
                )
              : SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        body: Container(
          padding: const EdgeInsets.only(
            top: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.h4(
                CollectorLocalizations.of(context).centralizingJourney,
                color: SeniorColors.secondaryColor900,
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              SeniorText.body(
                CollectorLocalizations.of(context).haveControl,
                color: SeniorColors.secondaryColor900,
              ),
              const SizedBox(
                height: SeniorSpacing.medium,
              ),
              SeniorText.small(
                CollectorLocalizations.of(context).shortcutsTimeControl,
                color: SeniorColors.neutralColor600,
              ),
              const SizedBox(
                height: SeniorSpacing.normal,
              ),
              BlocBuilder<HubMenuCubit, BuildMenuState>(
                bloc: widget._hubMenuCubit,
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: widget._hubMenuCubit.getTotalItems(),
                      itemBuilder: (context, index) {
                        var hubMenuEntity = widget._hubMenuCubit.getHubMenuEntity(
                          index,
                        );
                        return HubMenuWidget(
                          icon: hubMenuEntity.iconData,
                          onTap: hubMenuEntity.onTap,
                          title: hubMenuEntity.title,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
