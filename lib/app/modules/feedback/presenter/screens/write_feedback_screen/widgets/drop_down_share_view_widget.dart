import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../enums/feedback_visibility_enum.dart';

class DropDownShareViewWidget extends StatefulWidget {
  final Function(dynamic) onChanged;
  final FeedbackVisibilityEnum? selectedItem;
  final bool disabled;
  final AuthorizationBloc authorizationBloc;

  const DropDownShareViewWidget({
    Key? key,
    required this.onChanged,
    required this.selectedItem,
    required this.authorizationBloc,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<DropDownShareViewWidget> createState() {
    return _DropDownShareViewWidgetState();
  }
}

class _DropDownShareViewWidgetState extends State<DropDownShareViewWidget> {
  @override
  Widget build(BuildContext context) {
    FeedbackVisibilityEnum? selectedItem = widget.selectedItem;
    List<SeniorDropdownButtonItem> items = [];

    return BlocBuilder<AuthorizationBloc, AuthorizationState>(
      bloc: widget.authorizationBloc,
      builder: (context, state) {
        if (state is LoadedAuthorizationState) {
          items = getListDropdownMenuItem(
            authorizationEntity: state.authorizationEntity,
          );

          if (selectedItem == null) {
            selectedItem = items.isNotEmpty ? items.first.value : '';
            widget.onChanged(selectedItem);
          }
        }

        return SeniorDropdownButton(
          label: context.translate.selectSharingLabel,
          items: items,
          value: selectedItem,
          onSelected: widget.onChanged,
          helper: context.translate.selectSharingSubtitle,
          disabled: widget.disabled,
        );
      },
    );
  }

  List<SeniorDropdownButtonItem> getListDropdownMenuItem({
    required AuthorizationEntity authorizationEntity,
  }) {
    List<SeniorDropdownButtonItem> items = [];

    if (authorizationEntity.allowToMakeFeedbackVisibleToEmployeeAndManager) {
      items.add(
        SeniorDropdownButtonItem(
          value: FeedbackVisibilityEnum.employee,
          title: context.translate.feedbackVisibilityDropDownEmployee,
        ),
      );
    }

    if (authorizationEntity.allowToMakeFeedbackVisibleToManager) {
      items.add(
        SeniorDropdownButtonItem(
          value: FeedbackVisibilityEnum.leader,
          title: context.translate.feedbackVisibilityDropDownLeader,
        ),
      );
    }

    if (authorizationEntity.allowToMakeFeedbackVisibleToEmployee) {
      items.add(
        SeniorDropdownButtonItem(
          value: FeedbackVisibilityEnum.onlyEmployee,
          title: context.translate.feedbackVisibilityDropDownOnlyEmployee,
        ),
      );
    }

    if (authorizationEntity.allowToMakeFeedbackVisibleToEvaluator) {
      items.add(
        SeniorDropdownButtonItem(
          title: context.translate.feedbackVisibilityDropDownEvaluator,
          value: FeedbackVisibilityEnum.evaluator,
        ),
      );
    }
    return items;
  }
}
