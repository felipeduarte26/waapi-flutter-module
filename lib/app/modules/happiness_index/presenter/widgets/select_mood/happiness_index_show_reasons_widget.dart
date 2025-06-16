import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../domain/entities/happiness_index_group_entity.dart';
import '../../../domain/entities/happiness_index_reason_entity.dart';
import 'happiness_index_reasons_tag_widget.dart';

class HappinessIndexShowReasonsWidget extends StatefulWidget {
  final HappinessIndexGroupEntity groupReasons;
  final List<HappinessIndexReasonEntity> reasons;
  final bool canSelect;

  const HappinessIndexShowReasonsWidget({
    super.key,
    required this.groupReasons,
    required this.reasons,
    this.canSelect = false,
  });

  @override
  State<HappinessIndexShowReasonsWidget> createState() => _HappinessIndexShowReasonsWidgetState();
}

class _HappinessIndexShowReasonsWidgetState extends State<HappinessIndexShowReasonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SeniorText.label(
          widget.groupReasons.name!,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: widget.groupReasons.subgroups!.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.groupReasons.subgroups![index].isDefault!)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: SeniorSpacing.xxsmall,
                    ),
                    child: SeniorText.small(
                      widget.groupReasons.subgroups?[index].name ?? '',
                      emphasis: true,
                    ),
                  ),
                const SizedBox(
                  height: SeniorSpacing.small,
                ),
                Wrap(
                  children: widget.groupReasons.subgroups![index].reasons!
                      .map(
                        (reason) => HappinessIndexReasonsTagWidget(
                          displayLabel: reason.description!,
                          selected: widget.reasons.contains(reason),
                          select: () {
                            if (widget.canSelect) {
                              _selectReasons(
                                reason: reason,
                              );
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void _selectReasons({required HappinessIndexReasonEntity reason}) {
    if (widget.reasons.contains(reason)) {
      widget.reasons.remove(reason);
    } else {
      widget.reasons.add(reason);
    }
    setState(() {});
  }
}
