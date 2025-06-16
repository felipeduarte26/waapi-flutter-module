import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

class PersonListItemWidget extends StatelessWidget {
  final ImageProvider? imageProvider;
  final String personName;
  final String? personJobPosition;
  final String? personId;
  final IconData? leading;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final bool selected;
  final bool disabled;

  const PersonListItemWidget({
    Key? key,
    required this.imageProvider,
    required this.personName,
    this.personJobPosition,
    this.personId,
    this.leading,
    this.onTap,
    this.padding,
    this.selected = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Opacity(
            opacity: disabled ? 0.32 : 1,
            child: Row(
              children: [
                if (personId != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: SeniorSpacing.small,
                    ),
                    child: IgnorePointer(
                      child: SeniorCheckbox(
                        disabled: disabled,
                        onChanged: (changed) {},
                        actionOnTitle: true,
                        value: selected,
                      ),
                    ),
                  ),
                SeniorProfilePicture(
                  imageProvider: imageProvider,
                  radius: SeniorSpacing.xmedium,
                  name: personName,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.xsmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SeniorText.label(
                          personName,
                          textProperties: const TextProperties(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (personJobPosition != null)
                          SeniorText.small(
                            personJobPosition!,
                            textProperties: const TextProperties(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (leading != null)
                  Padding(
                    padding: const EdgeInsets.all(
                      SeniorSpacing.xsmall,
                    ),
                    child: SeniorIcon(
                      icon: leading!,
                      size: SeniorIconSize.small,
                      style: SeniorIconStyle(
                        color: isDark ? SeniorColors.pureWhite : SeniorColors.grayscale60,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
