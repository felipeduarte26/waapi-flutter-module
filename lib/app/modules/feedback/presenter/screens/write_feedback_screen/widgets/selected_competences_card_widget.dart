import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../domain/entities/skill_feedback_entity.dart';

class SelectedCompetencesCardWidget extends StatefulWidget {
  final void Function()? onPressed;
  final List<SkillFeedbackEntity> competences;

  const SelectedCompetencesCardWidget({
    Key? key,
    required this.onPressed,
    required this.competences,
  }) : super(key: key);

  @override
  State<SelectedCompetencesCardWidget> createState() {
    return _SelectedCompetencesCardWidgetState();
  }
}

class _SelectedCompetencesCardWidgetState extends State<SelectedCompetencesCardWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;
    return SeniorElevatedElement(
      elevation: SeniorElevations.dp01,
      borderRadius: SeniorRadius.xbig,
      child: Material(
        color: theme.cardTheme!.style!.backgroundColor,
        borderRadius: _setBorderRadius(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: _setBorderRadius(),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: SeniorSpacing.small,
                        left: SeniorSpacing.small,
                      ),
                      child: SeniorText.small(
                        context.translate.skills,
                        color: theme.textTheme!.smallStyle!.color,
                        textProperties: const TextProperties(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: SeniorSpacing.small,
                        bottom: SeniorSpacing.small,
                        left: SeniorSpacing.small,
                      ),
                      child: SeniorText.label(
                        competencesSelected(),
                        color: theme.textTheme!.labelStyle!.color,
                        textProperties: const TextProperties(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: SeniorSpacing.xsmall,
              ),
              IconButton(
                onPressed: widget.onPressed,
                icon: SeniorIcon(
                  icon: FontAwesomeIcons.xmark,
                  style: SeniorIconStyle(
                    color: theme.cardTheme!.style!.iconColor,
                  ),
                  size: SeniorIconSize.small,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String competencesSelected() {
    if (widget.competences.length == 1) {
      return widget.competences.first.name.toString();
    }
    return '${widget.competences.first.name.toString()} (+${widget.competences.length - 1})';
  }

  BorderRadius _setBorderRadius() {
    return const BorderRadius.only(
      topLeft: Radius.circular(SeniorRadius.xbig),
      topRight: Radius.circular(SeniorRadius.xbig),
      bottomLeft: Radius.circular(SeniorRadius.xbig),
      bottomRight: Radius.circular(SeniorRadius.xbig),
    );
  }
}
