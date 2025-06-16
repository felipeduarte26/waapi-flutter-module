import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../core/extension/media_query_extension.dart';
import '../../../core/extension/translate_extension.dart';
import '../presenter/blocs/search_naturality/search_naturality_bloc.dart';
import '../presenter/blocs/search_naturality/search_naturality_event.dart';
import '../presenter/widgets/select_naturality_bottom_sheet_content_widget.dart';

class OptionsSelectBottomSheet {
  static void selectNaturality({required BuildContext context, required SearchNaturalityBloc searchNaturalityBloc}) {
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.naturalityTitle,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Expanded(
          child: SelectNaturalityBottomSheetContentWidget(
            key: const Key('profile-input_personal_screen-select_naturality_bottom_sheet_content_widget'),
            searchNaturalityBloc: searchNaturalityBloc,
            initialTitle: context.translate.naturalitySearchHelp,
            initialSubtitle: context.translate.naturalitySearchHelpDescription,
            noFoundTitle: context.translate.naturalityNoDataFound,
            noFoundSubtitle: context.translate.naturalityNoDataFoundDescription,
            textFieldLabel: context.translate.naturality,
            isNaturality: true,
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        searchNaturalityBloc.add(ClearSearchNaturalityProfileEvent());
        Modular.to.pop();
      },
    );
  }
}
