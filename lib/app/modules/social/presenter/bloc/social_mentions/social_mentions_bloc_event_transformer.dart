import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<SocialMentionsEvent> debounce<SocialMentionsEvent>(
  Duration duration,
) {
  return (events, mapper) {
    return events.debounceTime(duration).flatMap(mapper);
  };
}
