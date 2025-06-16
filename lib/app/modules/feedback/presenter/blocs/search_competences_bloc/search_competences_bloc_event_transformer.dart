import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<GetCompetencesEvent> debounce<GetCompetencesEvent>(
  Duration duration,
) {
  return (events, mapper) {
    return events.debounceTime(duration).flatMap(mapper);
  };
}
