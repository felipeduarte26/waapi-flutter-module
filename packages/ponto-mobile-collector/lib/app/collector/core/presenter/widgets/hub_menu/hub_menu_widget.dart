import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_icon_size.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class HubMenuWidget extends StatelessWidget {
  final Function _onTap;
  final String _title;
  final IconData _iconData;

  const HubMenuWidget({
    super.key,
    required IconData icon,
    required String title,
    required Function onTap,
  })  : _iconData = icon,
        _title = title,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    var seniorCard = SeniorCard(
      rightIcon: FontAwesomeIcons.angleRight,
      onTap: () => _onTap.call(),
      child: Container(
        padding: const EdgeInsets.all(
          SeniorSpacing.xsmall,
        ),
        child: Row(
          children: [
            Icon(
              _iconData,
              color:
                  themeRepository.isCustomTheme() ? themeRepository.theme.primaryColor : SeniorColors.primaryColor500,
              size: SeniorIconSize.medium,
            ),
            const SizedBox(
              width: SeniorSpacing.normal,
            ),
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: SeniorText.cta(
                  _title,
                  color: SeniorColors.neutralColor800,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return seniorCard;
  }
}
