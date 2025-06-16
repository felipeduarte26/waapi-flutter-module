import 'dart:async';
import 'dart:developer';

import '../../domain/enums/work_indicator_type.dart';
import '../../domain/services/work_indicator_service.dart';

class WorkIndicatorServiceImpl implements WorkIndicatorService {
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();
  static final List<WorkIndicatorType> _workIndicatorTypes = [];

  @override
  bool addWorkIndicator({required WorkIndicatorType workIndicatorType}) {
    if (!_workIndicatorTypes.contains(workIndicatorType)) {
      _workIndicatorTypes.add(workIndicatorType);
    }

    bool inProgress = _workIndicatorTypes.isNotEmpty;
    _streamController.add(inProgress);
    log('WorkIndicatorService: add $workIndicatorType, inProgress: $inProgress');
    return inProgress;
  }

  @override
  bool removeWorkIndicator({required WorkIndicatorType workIndicatorType}) {
    _workIndicatorTypes.remove(workIndicatorType);

    bool inProgress = _workIndicatorTypes.isNotEmpty;
    _streamController.add(inProgress);
    log('WorkIndicatorService: remove $workIndicatorType, inProgress: $inProgress');
    return inProgress;
  }

  @override
  void dispose() {
    log('WorkIndicatorService: dispose');
    _streamController.close();
  }

  @override
  Stream<bool> get stream => _streamController.stream;

  @override
  bool get isWorkInProgress => _workIndicatorTypes.isNotEmpty;
}
