import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';
import '../../../../../../generated/l10n/collector_localizations.dart';
import '../../../../core/infra/utils/extension/media_query_extension.dart';
import '../widgets/face_registration_instructions.dart';

class InstructionsScreen extends StatefulWidget {
  final Function? _startReconnaissanceCall;
  const InstructionsScreen({Function? startReconnaissanceCall, super.key})
      : _startReconnaissanceCall = startReconnaissanceCall;

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();

    final bottomPadding = context.bottomSize;

    return Scaffold(
      body: SeniorColorfulHeaderStructure(
        hasTopPadding: false,
        title: SeniorText.label(
          CollectorLocalizations.of(context).facialTipsFacialRecognition,
          color: SeniorColors.pureWhite,
          darkColor: SeniorColors.grayscale5,
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.angleLeft,
            color: isDark ? SeniorColors.grayscale5 : SeniorColors.pureWhite,
          ),
          iconSize: SeniorSpacing.small,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: EdgeInsets.only(top: SeniorSpacing.normal, left: SeniorSpacing.normal, right: SeniorSpacing.normal, bottom: bottomPadding,),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SeniorText.h4(
                        CollectorLocalizations.of(context)
                            .facialFollowInstructionsCapture,
                      ),
                      const SizedBox(
                        height: SeniorSpacing.xsmall,
                      ),
                      const FaceRegistrationInstructions(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: SeniorSpacing.normal),
              SeniorButton(
                fullWidth: true,
                label: CollectorLocalizations.of(context)
                    .facialStartReconnaissance,
                onPressed: () {
                  widget._startReconnaissanceCall?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
