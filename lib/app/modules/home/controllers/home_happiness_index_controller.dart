import 'package:flutter/material.dart';
import 'package:senior_design_system/components/senior_snackbar/senior_snackbar_widget.dart';

import '../../../core/extension/translate_extension.dart';
import '../../../core/helper/locale_helper.dart';
import '../../happiness_index/presenter/blocs/happiness_index/happiness_index_bloc.dart';
import '../../happiness_index/presenter/blocs/happiness_index/happiness_index_event.dart';
import '../../happiness_index/presenter/blocs/happiness_index/happiness_index_state.dart';

class HomeHappinessIndexController {
  HappinessIndexBloc happinessIndexBloc;
  BuildContext context;

  HomeHappinessIndexController({
    required this.happinessIndexBloc,
    required this.context,
  });

  void handleHappinessIndexState({required HappinessIndexState state}) {
    if (state is HappinessIndexIsEnabledState) {
      happinessIndexBloc.add(
        GetCurrentHappinessIndexEvent(
          language: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
        ),
      );
    }

    if (state is ErrorOnSaveHappinessIndexState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.error(
          message: state.message ?? context.translate.happinessIndexErrorMessage,
        ),
      );
      _updateHappinessIndexModule();
    }

    if (state is SuccessOnSaveHappinessIndexState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SeniorSnackBar.success(
          message: context.translate.happinessIndexSuccessMessage,
        ),
      );
      _updateHappinessIndexModule();
    }
  }

  void _updateHappinessIndexModule() {
    happinessIndexBloc.add(
      HappinessIndexIsEnabledEvent(),
    );
  }
}
