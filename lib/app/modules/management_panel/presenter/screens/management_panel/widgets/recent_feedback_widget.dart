import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/widgets/icon_header_widget.dart';
import '../../../../../../core/widgets/state_card_widget.dart';
import '../../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../blocs/management_panel_feedback/management_panel_feedback_event.dart';
import '../blocs/management_panel_feedback/management_panel_feedback_state.dart';
import '../blocs/management_panel_screen/management_panel_screen_bloc.dart';
import '../blocs/management_panel_screen/management_panel_screen_state.dart';
import 'list_recent_feedbacks_widget.dart';

class RecentFeedbackWidget extends StatefulWidget {
  final bool disabled;

  const RecentFeedbackWidget({
    Key? key,
    required this.disabled,
  }) : super(key: key);

  @override
  State<RecentFeedbackWidget> createState() {
    return _RecentFeedbackWidgetState();
  }
}

class _RecentFeedbackWidgetState extends State<RecentFeedbackWidget> {
  late final ManagementPanelScreenBloc _managementPanelScreenBloc;
  late final AuthorizationBloc _authorizationBloc;

  @override
  void initState() {
    super.initState();
    _managementPanelScreenBloc = Modular.get<ManagementPanelScreenBloc>();
    _authorizationBloc = Modular.get<AuthorizationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconHeaderWidget(
          key: const Key('management-Panel_screen-description_recent_feedbacks'),
          title: context.translate.descriptionRecentFeedback,
          icon: FontAwesomeIcons.solidRightLeft,
        ),
        BlocBuilder<ManagementPanelScreenBloc, ManagementPanelScreenState>(
          bloc: _managementPanelScreenBloc,
          builder: (_, state) {
            final authorizationState = state.authorizationState as LoadedAuthorizationState;
            final bool isAllowToViewMyFeedbacks = authorizationState.authorizationEntity.allowToViewMyFeedbacks;
            final ManagementPanelFeedbackState managementPanelFeedbackState = state.managementPanelFeedbackState;

            if (managementPanelFeedbackState is LoadingManagementPanelLatestFeedbacksState) {
              return const Padding(
                padding: EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: Center(
                  child: WaapiLoadingWidget(
                    waapiLoadingSizeEnum: WaapiLoadingSizeEnum.small,
                    key: Key('management-Panel_screen-recent_feedbacks-loading_state'),
                  ),
                ),
              );
            }

            if (managementPanelFeedbackState is LoadedManagementPanelLatestFeedbacksState) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: SeniorSpacing.normal,
                ),
                child: ListRecentFeedbacksWidget(
                  key: const Key('management-Panel_screen-recent_feedbacks-state_loaded'),
                  latestFeedbacks: managementPanelFeedbackState.latestFeedbacks,
                  disabled: widget.disabled,
                ),
              );
            }

            if (managementPanelFeedbackState is ErrorManagementPanelLatestFeedbacksState) {
              return StateCardWidget(
                key: const Key('management-Panel_screen-recent_feedbacks-error_state-card'),
                message: context.translate.managementPanelRecentFeedbackTextError,
                textButton: context.translate.tryAgain,
                onTap: () => _managementPanelScreenBloc.managementPanelFeedbackBloc.add(
                  GetLatestFeedbacksEvent(
                    isAllowToViewMyFeedbacks: isAllowToViewMyFeedbacks,
                  ),
                ),
                showButton: true,
                iconData: FontAwesomeIcons.solidTriangleExclamation,
                disabled: widget.disabled,
              );
            }

            if (managementPanelFeedbackState is EmptyManagementPanelLatestFeedbacksState) {
              final authorizationState = _authorizationBloc.state as LoadedAuthorizationState;
              return StateCardWidget(
                key: const Key('management-Panel_screen-recent_feedbacks-button-request_feedback'),
                message: context.translate.recentsFeedbackReceivedEmptyState,
                textButton: context.translate.textButtonCardFeedbackEmpty,
                onTap: () => Modular.to.pushNamed(FeedbackRoutes.requestFeedbackScreenInitialRoute),
                showButton: authorizationState.authorizationEntity.allowToRequestFeedback,
                iconData: FontAwesomeIcons.solidRightLeft,
                disabled: widget.disabled,
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
