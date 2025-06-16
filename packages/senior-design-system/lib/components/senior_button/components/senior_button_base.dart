import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_text/senior_text.dart';

abstract class SeniorButtonBase extends StatelessWidget {
  SeniorButtonBase({
    Key? key,
    required this.label,
    this.disabled = false,
    required this.onPressed,
    this.fullWidth = false,
    this.busy = false,
    this.busyMessage,
    this.icon,
  }) : super(key: key);

  final String label;
  final bool disabled;
  final VoidCallback onPressed;
  final bool fullWidth;
  final bool busy;
  final String? busyMessage;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool _disabled = disabled || busy;

    return Material(
      color: Colors.transparent,
      child: Semantics(
        button: true,
        enabled: !_disabled,
        child: InkWell(
          onTap: !_disabled ? onPressed : null,
          child: Ink(
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: _disabled
                    ? defineDisabledBorderColor(context)
                    : defineBorderColor(context),
                width: 2.0,
              ),
              color: _disabled
                  ? defineDisabledBackgroundColor(context)
                  : defineBackgroundColor(context),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildButtonContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButtonContent(BuildContext context) {
    final bool _disabled = disabled || busy;

    if (busy) {
      return Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
            width: 20.0,
            child: CircularProgressIndicator(
              color: defineLoaderColor(context),
              strokeWidth: 3.0,
            ),
          ),
          const SizedBox(width: SeniorSpacing.small),
          Flexible(
            child: SeniorText.cta(
              busyMessage ?? label,
              style: TextStyle(
                height: 0,
                color: _disabled
                    ? defineDisabledContentColor(context)
                    : defineContentColor(context),
              ),
              textProperties: const TextProperties(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon != null
            ? Padding(
                padding: const EdgeInsets.only(right: SeniorSpacing.small),
                child: Icon(
                  icon,
                  size: 14.0,
                  color: _disabled
                      ? defineDisabledContentColor(context)
                      : defineContentColor(context),
                ),
              )
            : const SizedBox.shrink(),
        Flexible(
          child: SeniorText.cta(
            label,
            style: TextStyle(
              height: 0,
              color: _disabled
                  ? defineDisabledContentColor(context)
                  : defineContentColor(context),
            ),
            textProperties: const TextProperties(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  @protected
  Color defineContentColor(BuildContext context);

  @protected
  Color defineDisabledContentColor(BuildContext context);

  @protected
  Color defineBackgroundColor(BuildContext context) => Colors.transparent;

  @protected
  Color defineDisabledBackgroundColor(BuildContext context) =>
      Colors.transparent;

  @protected
  Color defineBorderColor(BuildContext context) => Colors.transparent;

  @protected
  Color defineDisabledBorderColor(BuildContext context) => Colors.transparent;

  @protected
  Color defineLoaderColor(BuildContext context) => Colors.transparent;
}
