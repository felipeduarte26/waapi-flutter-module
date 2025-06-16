import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import 'dependent_considered_item_widget.dart';

class DependentConsideredListWidget extends StatelessWidget {
  final bool isAccountedForIRRF;
  final bool isEligibleToFamilyAllowance;
  final bool isEligibleToAlimony;

  const DependentConsideredListWidget({
    Key? key,
    required this.isAccountedForIRRF,
    required this.isEligibleToFamilyAllowance,
    required this.isEligibleToAlimony,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool irrf = isAccountedForIRRF;
    bool familySalary = isEligibleToFamilyAllowance;
    bool alimony = isEligibleToAlimony;
    return (isAccountedForIRRF || isEligibleToFamilyAllowance || isEligibleToAlimony)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeniorText.small(
                '${context.translate.dependentConsideredInCalculation}:',
              ),
              SizedBox(
                height: 30,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    vertical: SeniorSpacing.xxsmall,
                  ),
                  itemBuilder: (_, index) {
                    if (irrf) {
                      irrf = false;
                      return DependentConsideredItemWidget(
                        text: context.translate.irrf,
                      );
                    } else if (familySalary) {
                      familySalary = false;
                      return DependentConsideredItemWidget(
                        text: context.translate.familySalary,
                      );
                    } else if (alimony) {
                      alimony = false;
                      return DependentConsideredItemWidget(
                        text: context.translate.alimony,
                      );
                    }

                    return const SizedBox.shrink();
                  },
                  itemCount: 3,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: SeniorSpacing.xsmall,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
