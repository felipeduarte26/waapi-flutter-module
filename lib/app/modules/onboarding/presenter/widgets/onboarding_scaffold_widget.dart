import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/senior_page_indicator.dart';
import '../../../../core/widgets/waapi_colorful_header.dart';
import 'content_view_page_widget.dart';

class OnboardingScaffoldWidget extends StatefulWidget {
  final List<ContentViewPageWidget> contentViewPageWidgets;
  final PageController pageController;
  final VoidCallback nextPageOnboardingEvent;
  final String? title;

  const OnboardingScaffoldWidget({
    Key? key,
    required this.contentViewPageWidgets,
    required this.pageController,
    required this.nextPageOnboardingEvent,
    this.title,
  }) : super(key: key);

  @override
  State<OnboardingScaffoldWidget> createState() {
    return _OnboardingScaffoldWidgetState();
  }
}

class _OnboardingScaffoldWidgetState extends State<OnboardingScaffoldWidget> {
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return Scaffold(
      backgroundColor: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
      body: WaapiColorfulHeader(
        key: const Key('onboarding-senior_colorful_header_structure'),
        titleLabel: widget.title ?? '',
        hasTopPadding: false,
        hideLeading: true,
        body: SizedBox(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (newPage) {
              setState(() {
                currentPage = newPage;
              });
            },
            key: const Key('onboarding-page_view'),
            controller: widget.pageController,
            children: widget.contentViewPageWidgets,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: theme.colorfulHeaderStructureTheme!.style!.bodyColor,
        child: Padding(
          padding: const EdgeInsets.all(SeniorSpacing.normal),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SeniorPageIndicator(
                length: widget.contentViewPageWidgets.length,
                currentPage: currentPage,
              ),
              const SizedBox(
                height: SeniorSpacing.big,
              ),
              SeniorButton(
                key: const Key('onboarding-senior_button'),
                label: currentPage == widget.contentViewPageWidgets.length - 1
                    ? context.translate.finish
                    : context.translate.next,
                fullWidth: true,
                onPressed: widget.nextPageOnboardingEvent,
              ),
              SizedBox(
                height: context.bottomSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
