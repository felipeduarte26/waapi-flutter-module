import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../senior_design_system.dart';

/// Types of information that are displayed in the component.
/// The types are [InfoType.expense] and [InfoType.revenue].
enum InfoType {
  expense,
  revenue,
}

class SeniorBalance extends StatefulWidget {
  /// Creates the Balance component of the SDS.
  ///
  /// The [labels], [values] and [moneySign] parameters are required.
  const SeniorBalance({
    Key? key,
    required this.labels,
    required this.values,
    required this.moneySign,
    this.style,
  })  : assert(labels.length == values.length && values.length != 0),
        super(key: key);

  /// The list of labels that will be displayed in the component.
  /// The list cannot be empty and must have the same amount of elements as [values].
  final List<String> labels;

  /// The list of values that will be displayed in the component.
  /// The list cannot be empty and must have the same amount of elements as [labels].
  final List<String> values;

  /// The money sign.
  final String moneySign;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorBalanceStyle.selectedControllerColor] the color of the selected selection display.
  /// [SeniorBalanceStyle.textColor] the component's text color.
  /// [SeniorBalanceStyle.unselectedControllerColor] the color of the unchecked selection display.
  final SeniorBalanceStyle? style;

  @override
  _SeniorBalanceState createState() => _SeniorBalanceState();
}

class _SeniorBalanceState extends State<SeniorBalance> {
  bool _showValues = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeRepository>(context).theme;

    final signColor = widget.style?.signColor ??
        theme.balanceTheme?.style?.signColor ??
        SeniorColors.grayscale60;

    final txtColor = widget.style?.textColor ??
        theme.balanceTheme?.style?.textColor ??
        SeniorColors.grayscale60;

    final selecCtrlColor = widget.style?.selectedControllerColor ??
        theme.balanceTheme?.style?.selectedControllerColor ??
        SeniorColors.grayscale50;

    final uselecCtrlColor = widget.style?.unselectedControllerColor ??
        theme.balanceTheme?.style?.unselectedControllerColor ??
        SeniorColors.grayscale20;

    return Container(
      height: 64.0,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: widget.values.length,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _showValues = false;
                  _index = index;
                });
              },
              itemBuilder: (_, currentIndex) {
                return Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.labels[_index],
                            style: SeniorTypography.small(
                              color: txtColor,
                            ),
                          ),
                          //SizedBox(width: 8.0),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                _showValues = !_showValues;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SeniorSpacing.small,
                                vertical: SeniorSpacing.xxsmall,
                              ),
                              child: Icon(
                                _showValues
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: SeniorIconSize.xsmall,
                                color: txtColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: SeniorSpacing.xxsmall,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.moneySign,
                              style: SeniorTypography.small(
                                color: signColor,
                              ),
                            ),
                            Visibility(
                              visible: _showValues,
                              replacement: Text(
                                '**********',
                                style: SeniorTypography.h3(
                                  color: txtColor,
                                ),
                              ),
                              child: Text(
                                widget.values[_index],
                                style: SeniorTypography.h3(
                                  color: txtColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: SeniorSpacing.xxsmall,
            ),
            child: Row(
              children: widget.values
                  .asMap()
                  .map((index, value) => MapEntry(
                      index,
                      Container(
                        height: 2.0,
                        width: 29.0,
                        color:
                            index == _index ? selecCtrlColor : uselecCtrlColor,
                        margin: const EdgeInsets.only(right: 2.0),
                      )))
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
