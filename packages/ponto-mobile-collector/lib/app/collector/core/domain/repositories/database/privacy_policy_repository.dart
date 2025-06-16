import '../../../external/drift/collector_database.dart';
import '../../entities/privacy_policy_entity.dart';

abstract class PrivacyPolicyRepository {
  Future<bool> exist({
    required int version,
  });

  Future<PrivacyPolicyEntity?> findByVersion({
    required int version,
  });

  Future<PrivacyPolicyEntity?> getLastVersionSaved();

  Future<int> insert({
    required PrivacyPolicyEntity privacyPolicy,
  });

  Future<bool> update({
    required PrivacyPolicyEntity privacyPolicy,
  });

  Future<bool> save({
    required PrivacyPolicyEntity privacyPolicy,
  });

  PrivacyPolicyTableData convertToTable({
    required PrivacyPolicyEntity privacyPolicy,
  });

  PrivacyPolicyEntity convertToEntity({
    required PrivacyPolicyTableData tableData,
  });
}
