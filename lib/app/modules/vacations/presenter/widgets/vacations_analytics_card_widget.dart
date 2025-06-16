import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/translate_extension.dart';
import '../../../../core/helper/string_helper.dart';
import '../../../../core/widgets/waapi_card_widget.dart';

class VacationsAnalyticsCardWidget extends StatefulWidget {
  final String title;
  final double days;
  final IconData icon;
  final bool disabled;
  final VoidCallback? onTap;

  const VacationsAnalyticsCardWidget({
    Key? key,
    required this.title,
    required this.days,
    required this.icon,
    required this.disabled,
    this.onTap,
  }) : super(key: key);

  @override
  State<VacationsAnalyticsCardWidget> createState() {
    return _VacationsAnalyticsCardWidgetState();
  }
}

class _VacationsAnalyticsCardWidgetState
    extends State<VacationsAnalyticsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      onTap: widget.onTap,
      disabled: widget.disabled,
      height: 80,
      showActionIcon: false,
      child: Row(
        children: [
          CircleAvatar(
            child: SeniorGradientIcon(
              icon: widget.icon,
              sizeIcon: SeniorSpacing.xmedium,
              boxSize: SeniorSpacing.xmedium,
            ),
          ),
          const SizedBox(
            width: SeniorSpacing.normal,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SeniorText.small(
                widget.title,
                color: SeniorColors.neutralColor500,
              ),
              SeniorText.cta(
                _showFormattedDays(
                  days: widget.days,
                ),
                color: SeniorColors.neutralColor800,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _showFormattedDays({
    required double days,
  }) {
    final pointToCommaDays = StringHelper.doubleToStringFormatter(
      value: days,
    );
    final textDays = days <= 1 ? context.translate.day : context.translate.days;

    return '$pointToCommaDays $textDays';
  }
}
