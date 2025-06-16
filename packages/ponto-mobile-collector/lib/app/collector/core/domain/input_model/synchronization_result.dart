
import '../../infra/utils/enum/synchronization_enum.dart';

class SynchronizationResult {
  final SynchronizationStatus _status;
  final SynchronizationMessage _message;

  SynchronizationResult(this._status, this._message);

  SynchronizationStatus get status => _status;
  SynchronizationMessage get message => _message;
}
