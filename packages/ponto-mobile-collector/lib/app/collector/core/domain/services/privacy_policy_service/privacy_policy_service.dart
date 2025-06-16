import '../../entities/privacy_policy_entity.dart';

abstract class PrivacyPolicyService {
  Future<PrivacyPolicyEntity?> getLastPrivacyPoliceVersion();
}
