import 'dart:async';

import '../enums/work_indicator_type.dart';

abstract class WorkIndicatorService {
  bool addWorkIndicator({required WorkIndicatorType workIndicatorType});
  bool removeWorkIndicator({required WorkIndicatorType workIndicatorType});
  void dispose();
  bool get isWorkInProgress;
  Stream<bool> get stream;
}
