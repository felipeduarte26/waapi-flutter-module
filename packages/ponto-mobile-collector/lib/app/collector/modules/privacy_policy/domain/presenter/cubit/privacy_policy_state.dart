import '../../../../../core/domain/entities/privacy_policy_entity.dart';

abstract class PrivacyPolicyBaseState {}

class LoadingContentState implements PrivacyPolicyBaseState {}

class HasNoConectionState implements PrivacyPolicyBaseState {}
class ReadContentState implements PrivacyPolicyBaseState {
  final PrivacyPolicyEntity privacyPolicyEntity;
  final String dateTimeEventRead;

  ReadContentState({
    required this.dateTimeEventRead,
    required this.privacyPolicyEntity,
  });
}
