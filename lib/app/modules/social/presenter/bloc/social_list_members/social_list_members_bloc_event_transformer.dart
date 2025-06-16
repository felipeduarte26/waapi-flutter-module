import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<SocialListMembersEvent> debounce<SocialListMembersEvent>(
  Duration duration,
) {
  return (events, mapper) {
    return events.debounceTime(duration).flatMap(mapper);
  };
}
