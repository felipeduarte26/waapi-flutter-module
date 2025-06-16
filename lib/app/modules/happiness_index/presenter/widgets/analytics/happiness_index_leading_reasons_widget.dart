// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/extension/translate_extension.dart';
import '../../../domain/entities/happiness_index_group_entity.dart';
import '../../../domain/entities/happiness_index_reason_entity.dart';

class HappinessIndexLeadingReasonsWidget extends StatelessWidget {
  final List<HappinessIndexGroupEntity> reasons;

  const HappinessIndexLeadingReasonsWidget({
    super.key,
    required this.reasons,
  });

  List<_TotalReasons> _reasons() {
    final totalReasons = <HappinessIndexReasonEntity>[];

    if (reasons.isNotEmpty) {
      for (var group in reasons) {
        group.subgroups?.forEach((subgroup) {
          totalReasons.addAll(subgroup.reasons ?? []);
        });
      }
    }

    List<_TotalReasons> leadingReasons = [];
    for (var reason in totalReasons.toSet()) {
      leadingReasons.add(
        _TotalReasons(
          description: reason.description ?? '',
          total: totalReasons.where((e) => e == reason).length,
        ),
      );
    }

    leadingReasons.sort((a, b) => b.total.compareTo(a.total));
    return leadingReasons;
  }

  @override
  Widget build(BuildContext context) {
    int totalLines = _reasons().toSet().length;
    totalLines = totalLines > 10 ? 10 : totalLines;
    final isDarkTheme = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SeniorSpacing.normal,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeniorText.label(
            context.translate.mainReasons,
            color: SeniorColors.grayscale90,
            darkColor: SeniorColors.grayscale30,
          ),
          if (totalLines > 0)
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: SeniorSpacing.big,
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? null
                        : isDarkTheme
                            ? SeniorColors.grayscale80
                            : SeniorColors.grayscale10,
                    borderRadius: BorderRadius.vertical(
                      top: index == 0 ? const Radius.circular(SeniorRadius.xxbig) : Radius.zero,
                      bottom: index == totalLines - 1 ? const Radius.circular(SeniorRadius.xxbig) : Radius.zero,
                    ),
                    border: Border.all(
                      color: SeniorColors.secondaryColor200,
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.normal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SeniorText.body(
                            _reasons().elementAt(index).description,
                            color: SeniorColors.grayscale90,
                            textProperties: const TextProperties(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SeniorText.body(
                          '${_reasons().elementAt(index).total}',
                          color: SeniorColors.grayscale70,
                          darkColor: SeniorColors.grayscale20,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: totalLines,
              padding: const EdgeInsetsDirectional.only(
                top: SeniorSpacing.xsmall,
              ),
            ),
          if (totalLines == 0)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SeniorSpacing.normal,
              ),
              child: Center(
                child: SeniorText.label(
                  context.translate.noRegisterOnWeek,
                  color: SeniorColors.grayscale50,
                  darkColor: SeniorColors.grayscale40,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TotalReasons extends Equatable {
  final String description;
  final int total;

  const _TotalReasons({
    required this.description,
    required this.total,
  });

  @override
  List<Object?> get props => [
        total,
        description,
      ];
}
