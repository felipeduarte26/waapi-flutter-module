import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FeedbackSuggestionTypeEnum {
  recognition,
  improvement;

  String text(AppLocalizations appLocalizations) {
    switch (this) {
      case recognition:
        return appLocalizations.feedbackSuggestionFeedbackTypePraise;
      case improvement:
        return appLocalizations.feedbackSuggestionFeedbackTypeImprovement;
    }
  }
}
