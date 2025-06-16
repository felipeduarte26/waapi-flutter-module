import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class ReportIncomeCardWidget extends StatelessWidget {
  final int year;
  final String employerName;
  final Function()? onTap;

  const ReportIncomeCardWidget({
    super.key,
    required this.year,
    required this.employerName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    final theme = Provider.of<ThemeRepository>(context).theme;

    return SeniorCard(
      withElevation: true,
      height: SeniorSpacing.xxhuge,
      margin: EdgeInsets.zero,
      style: SeniorCardStyle(
        backgroundColor: isDark ? theme.cardTheme!.style!.backgroundColor : SeniorColors.pureWhite,
      ),
      leftIcon: FontAwesomeIcons.solidFileInvoiceDollar,
      rightIcon: FontAwesomeIcons.solidShareFromSquare,
      onTap: onTap,
      leftIconColor: theme.primaryColor,
      rightIconColor: SeniorColors.secondaryColor,
      child: Row(
        children: [
          Expanded(
            child: SeniorText.label(
              '$year - $employerName',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
              textProperties: const TextProperties(
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
