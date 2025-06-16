import 'package:flutter/material.dart';
import 'package:senior_design_system/components/senior_dropdown_button/senior_dropdown_button.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../domain/entities/disability_entity.dart';
import 'show_disability_widget.dart';

class ListDisabilitiesWidget extends StatefulWidget {
  final List<DisabilityEntity> disabilities;
  final List<SeniorDropdownButtonItem> selectedDisabilitiesItems;
  final List<SeniorDropdownButtonItem> disabilitiesItems;

  const ListDisabilitiesWidget({
    Key? key,
    required this.disabilities,
    required this.selectedDisabilitiesItems,
    required this.disabilitiesItems,
  }) : super(key: key);

  @override
  State<ListDisabilitiesWidget> createState() {
    return _ListDisabilitiesWidgetState();
  }
}

class _ListDisabilitiesWidgetState extends State<ListDisabilitiesWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ShowDisabilityWidget(
          disability: widget.disabilities[index],
          disabilitiesItems: widget.disabilitiesItems,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(
        height: SeniorSpacing.small,
      ),
      itemCount: widget.selectedDisabilitiesItems.length,
    );
  }
}
