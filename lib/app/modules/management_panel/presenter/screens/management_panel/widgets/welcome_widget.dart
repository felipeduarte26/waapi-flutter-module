// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import 'happiness_index/happiness_index_status_widget.dart';

class WelcomeWidget extends StatelessWidget {
  final String firstName;
  final HappinessIndexBloc _happinessIndexBloc;

  const WelcomeWidget({
    Key? key,
    required this.firstName,
    required HappinessIndexBloc happinessIndexBloc,
  })  : _happinessIndexBloc = happinessIndexBloc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
        bottom: SeniorSpacing.normal,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SeniorText.h4(
            context.translate.welcomeMessage(firstName),
            color: SeniorColors.secondaryColor900,
            darkColor: SeniorColors.grayscale5,
            textProperties: const TextProperties(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(
            width: SeniorSpacing.xxsmall,
          ),
          HappinessIndexStatusWidget(
            happinessIndexBloc: _happinessIndexBloc,
          ),
        ],
      ),
    );
  }
}
