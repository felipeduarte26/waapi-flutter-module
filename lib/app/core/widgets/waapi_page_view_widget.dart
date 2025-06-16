import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../widgets/waapi_colorful_header.dart';
import 'employee_bottom_sheet_widget.dart';
import 'waapi_loading_widget.dart';

class WaapiPageViewWidget extends StatefulWidget {
  final int currentStep;

  /// PageController to control the page view
  final PageController pageController;

  /// Validation to show screen exit message without saving data
  final bool validationExitIncompleteAction;

  /// ages that will appear on the screen
  final List<Widget> listPagesViews;

  /// If you have any validation to do before the pages appear. If you want to show the page directly, send true.
  final bool loadedPages;

  /// Validation to disable the top button
  final bool disableTopButton;

  /// Validation for top button to stay in loading state
  final bool busyTopButton;

  ///function that the top button will perform when pressing
  final VoidCallback onPressedTopButton;

  /// label for top button
  final String labelTopButton;

  /// Validation to disable the bottom button
  final bool disableBottomButton;

  /// Validation for bottom button to stay in loading state
  final bool busyBottomButton;

  ///function that the bottom button will perform when pressing
  final VoidCallback onPressedBottomButton;

  /// label for bottom button
  final String labelBottomButton;

  ///label title for the showdialog
  final String labelTitleDialog;

  ///label message for the showdialog
  final String labelContentDialog;

  ///label Ghostbutton for the showdialog
  final String? labelGhostButtonDialog;

  /// function that the ghost button will perform when pressing
  final VoidCallback? onPressedGhostButtonDialog;

  /// label for the ActionButtonDialog
  final String labelActionButtonDialog;

  /// function that the action button will perfom when pressing
  final VoidCallback? onPressedActionButtonDialog;

  final List<Widget>? actions;

  final String titleScreen;

  const WaapiPageViewWidget({
    Key? key,
    required this.pageController,
    required this.validationExitIncompleteAction,
    required this.listPagesViews,
    required this.loadedPages,
    required this.disableTopButton,
    required this.busyTopButton,
    required this.currentStep,
    required this.onPressedTopButton,
    required this.labelTopButton,
    required this.disableBottomButton,
    required this.busyBottomButton,
    required this.onPressedBottomButton,
    required this.labelBottomButton,
    required this.labelTitleDialog,
    required this.labelContentDialog,
    this.labelGhostButtonDialog,
    this.onPressedGhostButtonDialog,
    required this.labelActionButtonDialog,
    this.onPressedActionButtonDialog,
    required this.titleScreen,
    this.actions,
  }) : super(key: key);

  @override
  State<WaapiPageViewWidget> createState() {
    return _WaapiPageViewWidgetState();
  }
}

class _WaapiPageViewWidgetState extends State<WaapiPageViewWidget> {
  bool openModal = false;

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);

    void onWillPop() {
      if (openModal) return;
      if (widget.validationExitIncompleteAction) {
        openModal = true;
        showDialog(
          barrierDismissible: false,
          useRootNavigator: true,
          context: context,
          builder: (context) {
            return SeniorModal(
              title: widget.labelTitleDialog,
              content: widget.labelContentDialog,
              defaultAction: SeniorModalAction(
                label: widget.labelGhostButtonDialog!,
                action: () {
                  if (widget.onPressedGhostButtonDialog != null) {
                    widget.onPressedGhostButtonDialog!();
                    openModal = false;
                  }
                },
              ),
              otherAction: SeniorModalAction(
                label: widget.labelActionButtonDialog,
                action: widget.onPressedActionButtonDialog ?? () {},
                danger: true,
              ),
            );
          },
        );
      } else {
        Modular.to.pop();
      }
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) async => onWillPop(),
      child: Scaffold(
        body: WaapiColorfulHeader(
          actions: widget.actions,
          onTapBack: onWillPop,
          titleLabel: widget.titleScreen,
          body: widget.loadedPages
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(SeniorSpacing.normal),
                      child: SeniorStepper(
                        steps: widget.listPagesViews.length,
                        current: widget.currentStep,
                        style: themeRepository.isCustomTheme()
                            ? null
                            : SeniorStepperStyle(
                                uncompletedStepColor: themeRepository.isDarkTheme()
                                    ? SeniorColors.grayscale40
                                    : SeniorColors.neutralColor400,
                                currentStepColor: themeRepository.isDarkTheme()
                                    ? SeniorColors.primaryColor500
                                    : SeniorColors.primaryColor400,
                                completedStepColor: themeRepository.isDarkTheme()
                                    ? SeniorColors.primaryColor300
                                    : SeniorColors.primaryColor200,
                              ),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: widget.pageController,
                        children: widget.listPagesViews,
                        onPageChanged: (value) {},
                      ),
                    ),
                    EmployeeBottomSheetWidget(
                      horizontalPadding: true,
                      seniorButtons: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                          ),
                          child: SeniorButton(
                            disabled: widget.disableTopButton,
                            busy: widget.busyTopButton,
                            fullWidth: true,
                            label: widget.labelTopButton,
                            onPressed: widget.onPressedTopButton,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: SeniorSpacing.normal,
                          ),
                          child: SeniorButton.ghost(
                            disabled: widget.disableBottomButton,
                            fullWidth: true,
                            label: widget.labelBottomButton,
                            onPressed: widget.currentStep > 1 ? widget.onPressedBottomButton : onWillPop,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : const Center(
                  child: WaapiLoadingWidget(
                    key: Key('edit_persona_data_screen-loading_state'),
                  ),
                ),
        ),
      ),
    );
  }
}
