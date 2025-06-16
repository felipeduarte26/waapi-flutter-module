import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../domain/entities/feedback_entity.dart';
import '../blocs/details_received_feedback_bloc/details_received_feedback_event.dart';
import '../screens/details_received_feedback/blocs/details_received_feedback_screen_bloc/details_received_feedback_screen_bloc.dart';

class FeedbackToggleWidget extends StatelessWidget {
  final FeedbackEntity receivedFeedbackEntity;

  const FeedbackToggleWidget({
    Key? key,
    required this.receivedFeedbackEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detailsReceivedFeedbacksBloc = Modular.get<DetailsReceivedFeedbackScreenBloc>().detailsReceivedFeedbacksBloc;
    final bool isPublic = receivedFeedbackEntity.isPublic;

    return Visibility(
      visible: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: SeniorSpacing.xxsmall,
        ),
        child: SeniorSwitch(
          title: receivedFeedbackEntity.isPublic ? context.translate.feedbackPublic : context.translate.feedbackPrivate,
          value: isPublic,
          titlePosition: SeniorSwitchTitlePosition.right,
          onChanged: (value) {
            if (value == null) {
              return;
            }

            if (!value) {
              detailsReceivedFeedbacksBloc.add(
                SetFeedbackPrivateEvent(
                  feedbackEntity: receivedFeedbackEntity,
                ),
              );
            } else {
              detailsReceivedFeedbacksBloc.add(
                SetFeedbackPublicEvent(
                  feedbackEntity: receivedFeedbackEntity,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
