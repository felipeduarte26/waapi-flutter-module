enum SynchronizationMessage {
  syncClockingEventSyncSuccess('Synchronization successful.'),
  syncClockingEventSyncInternetUnavailable(
    'Unable to perform synchronization because there is no internet connection.',
  ),
  syncClockingEventSyncFailure('Failure performing synchronization.'),
  noFaceRegistered('No face registered.');

  const SynchronizationMessage(this.message);

  final String message;
}

enum SynchronizationStatus {
  success,
  warning,
  error;

  bool get isSuccess => this == SynchronizationStatus.success;
  bool get isWarning => this == SynchronizationStatus.warning;
  bool get isError => this == SynchronizationStatus.error;
}
