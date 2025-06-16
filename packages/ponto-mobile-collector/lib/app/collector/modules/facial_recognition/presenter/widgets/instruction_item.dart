import 'package:flutter/material.dart';
import 'package:senior_design_system/components/senior_text/senior_text_widget.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_icon_size.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

class InstructionItem extends StatelessWidget {
  final IconData icon;
  final String content;

  const InstructionItem({
    super.key,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SeniorSpacing.small,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: SeniorSpacing.medium,
            ),
            child: CircleAvatar(
              radius: 24,
              backgroundColor: SeniorColors.primaryColor100,
              child: Center(
                child: Icon(
                  icon,
                  color: SeniorColors.primaryColor800,
                  size: SeniorIconSize.small,
                ),
              ),
            ),
          ),
          Expanded(
            child: SeniorText.body(
              content,
            ),
          ),
        ],
      ),
    );
  }
}
