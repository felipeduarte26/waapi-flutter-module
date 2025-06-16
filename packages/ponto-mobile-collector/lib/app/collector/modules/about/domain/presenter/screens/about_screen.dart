import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../../core/domain/services/navigator/navigator_service.dart';
import '../../../../../core/presenter/widgets/loading/loading_widget.dart';
import '../cubit/about_cubit.dart';
import '../cubit/about_state.dart';

class AboutScreen extends StatefulWidget {
  final AboutCubit cubit;
  final NavigatorService navigatorService;

  const AboutScreen({
    super.key,
    required this.cubit,
    required this.navigatorService,
  });

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.cubit.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        title: SeniorText.label(
          CollectorLocalizations.of(context).about,
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
        body: Padding(
          padding: const EdgeInsets.all(SeniorSpacing.normal),
          child: getWidget(context),
        ),
      ),
    );
  }

/* @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshot) {
        return Scaffold(
          body: SeniorColorfulHeaderStructure(
            title: SeniorText.label(
              CollectorLocalizations.of(context).about,
              color: SeniorColors.pureWhite,
              darkColor: SeniorColors.pureWhite,
            ),
            leading: IconButton(
              icon: const Icon(
                FontAwesomeIcons.angleLeft,
                color: SeniorColors.pureWhite,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(SeniorSpacing.normal),
              child: content(snapshot.connectionState, context, snapshot.data),
            ),
          ),
        );
      },
    );
  }*/

  Widget getWidget(BuildContext context) {
    return BlocBuilder<AboutCubit, AboutBaseState>(
      bloc: widget.cubit,
      builder: (context, state) {
        if (state is ReadContentState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: SeniorSpacing.medium),
                    SeniorText.labelBold(
                      CollectorLocalizations.of(context).aboutScreenAppTitle,
                    ),
                    const SizedBox(height: SeniorSpacing.small),
                    SeniorText.smallBold(
                      CollectorLocalizations.of(context).aboutScreenVersion,
                    ),
                    SeniorText.small(widget.cubit.version),
                    const SizedBox(height: SeniorSpacing.big),
                    SeniorText.labelBold(
                      CollectorLocalizations.of(context).aboutScreenDeviceTitle,
                    ),
                    const SizedBox(height: SeniorSpacing.small),
                    SeniorText.smallBold(
                      CollectorLocalizations.of(context).aboutScreenIdentifier,
                    ),
                    SeniorText.small(
                      widget.cubit.identifier,
                      textProperties: const TextProperties(
                        softWrap: true,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const SizedBox(height: SeniorSpacing.xsmall),
                    SeniorText.smallBold(
                      CollectorLocalizations.of(context).aboutScreenModel,
                    ),
                    SeniorText.small(widget.cubit.model),
                    const SizedBox(height: SeniorSpacing.xsmall),
                    SeniorText.smallBold(
                      CollectorLocalizations.of(context).aboutScreenName,
                    ),
                    SeniorText.small(widget.cubit.name),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SeniorText.smallBold(
                      CollectorLocalizations.of(context).aboutScreenDevelopedBy,
                    ),
                    const SizedBox(height: SeniorSpacing.xsmall),
                    SvgPicture.asset(
                      'assets/icons/logo-senior.svg',
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return LoadingWidget(
          bottomLabel: CollectorLocalizations.of(context).loading,
        );
      },
    );

    /*return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LoadingWidget(
          bottomLabel: '',
        ),
      ],
    );*/
  }
}
