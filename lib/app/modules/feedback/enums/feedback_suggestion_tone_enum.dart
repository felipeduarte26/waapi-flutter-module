import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FeedbackSuggestionToneEnum {
  balanced,
  motivating,
  professional;

  String text(AppLocalizations appLocalizations) {
    switch (this) {
      case FeedbackSuggestionToneEnum.balanced:
        return appLocalizations.feedbackSuggestionToneBalanced;
      case motivating:
        return appLocalizations.feedbackSuggestionToneMotivator;
      case professional:
        return appLocalizations.feedbackSuggestionToneProfessional;
    }
  }
}
