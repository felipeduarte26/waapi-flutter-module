import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../extension/translate_extension.dart';

class UnderDevelopmentWidget extends StatelessWidget {
  const UnderDevelopmentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SeniorColors.neutralColor100,
        elevation: 0,
        leading: IconButton(
          onPressed: Modular.to.pop,
          icon: const SeniorIcon(
            icon: FontAwesomeIcons.angleLeft,
            size: SeniorSpacing.normal,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(SeniorSpacing.xsmall),
          child: SeniorText.h4(
            context.translate.titleUnderDevelopment,
            color: SeniorColors.neutralColor800,
            textProperties: const TextProperties(
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
