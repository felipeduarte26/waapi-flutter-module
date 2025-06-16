import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/synchronization_enum.dart';

void main() {
  group('SynchronizationMessage', () {
    test('syncClockingEventSyncSuccess message is correct', () {
      expect(
        SynchronizationMessage.syncClockingEventSyncSuccess.message,
        'Synchronization successful.',
      );
    });

    test('syncClockingEventSyncInternetUnavailable message is correct', () {
      expect(
        SynchronizationMessage.syncClockingEventSyncInternetUnavailable.message,
        'Unable to perform synchronization because there is no internet connection.',
      );
    });

    test('syncClockingEventSyncFailure message is correct', () {
      expect(
        SynchronizationMessage.syncClockingEventSyncFailure.message,
        'Failure performing synchronization.',
      );
    });

    test('noRegisteredFace message is correct', () {
      expect(
        SynchronizationMessage.noFaceRegistered.message,
        'No face registered.',
      );
    });
  });

  group('SynchronizationStatus', () {
    test('isSuccess returns true for success status', () {
      expect(SynchronizationStatus.success.isSuccess, isTrue);
    });

    test('isWarning returns true for warning status', () {
      expect(SynchronizationStatus.warning.isWarning, isTrue);
    });

    test('isError returns true for error status', () {
      expect(SynchronizationStatus.error.isError, isTrue);
    });

    test('isSuccess returns false for non-success status', () {
      expect(SynchronizationStatus.warning.isSuccess, isFalse);
      expect(SynchronizationStatus.error.isSuccess, isFalse);
    });

    test('isWarning returns false for non-warning status', () {
      expect(SynchronizationStatus.success.isWarning, isFalse);
      expect(SynchronizationStatus.error.isWarning, isFalse);
    });

    test('isError returns false for non-error status', () {
      expect(SynchronizationStatus.success.isError, isFalse);
      expect(SynchronizationStatus.warning.isError, isFalse);
    });
  });
}
