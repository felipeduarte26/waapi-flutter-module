import '../../exception/service_exception.dart';

enum ActivationSituationType {
  pending('PENDING'),

  authorized('AUTHORIZED'),

  rejected('REJECTED');

  final String value;

  const ActivationSituationType(this.value);

  static ActivationSituationType build(String value) {
    if (value == ActivationSituationType.pending.value) {
      return ActivationSituationType.pending;
    }

    if (value == ActivationSituationType.authorized.value) {
      return ActivationSituationType.authorized;
    }

    if (value == ActivationSituationType.rejected.value) {
      return ActivationSituationType.rejected;
    }

    throw ServiceException(message: 'ActivationSituationType not found');
  }
}
