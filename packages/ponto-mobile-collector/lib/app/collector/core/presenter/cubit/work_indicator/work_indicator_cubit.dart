import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/services/work_indicator_service.dart';
import 'work_indicator_state.dart';

/// Cubit used to indicate background work in progress
class WorkIndicatorCubit extends Cubit<WorkIndicatorState> {
  final WorkIndicatorService _workIndicatorService;
  late StreamSubscription<bool> _streamSubscription;

  WorkIndicatorCubit({
    required WorkIndicatorService workIndicatorService,
  })  : _workIndicatorService = workIndicatorService,
        super(WorkIndicatorUpdate()) {
    _streamSubscription = _workIndicatorService.stream.listen((workInProgress) {
      emit(WorkIndicatorUpdate());
      log('WorkIndicatorCubit: WorkIndicatorUpdate $isWorkInProgress');
    });
  }

  bool get isWorkInProgress => _workIndicatorService.isWorkInProgress;

  void dispose() async {
    await _streamSubscription.cancel();
    await super.close();
    log('WorkIndicatorCubit: dispose');
  }
}
