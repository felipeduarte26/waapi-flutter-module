import '../entities/privacy_policy_entity.dart';
import '../repositories/database/privacy_policy_repository.dart';
import '../services/privacy_policy_service/privacy_policy_service.dart';

abstract class GetLastVersionPrivacyPolicyUsecase {
  Future<PrivacyPolicyEntity?> call();
}

class GetLastVersionPrivacyPolicyUsecaseImpl
    implements GetLastVersionPrivacyPolicyUsecase {
  final PrivacyPolicyService _privacyPolicyService;
  final PrivacyPolicyRepository _privacyPolicyRepository;

  const GetLastVersionPrivacyPolicyUsecaseImpl({
    required PrivacyPolicyService privacyPolicyService,
    required PrivacyPolicyRepository privacyPolicyRepository,
  })  : _privacyPolicyService = privacyPolicyService,
        _privacyPolicyRepository = privacyPolicyRepository;

  @override
  Future<PrivacyPolicyEntity?> call() async {
    PrivacyPolicyEntity? lastVersionPrivacyPolicyFromServer =
        await _privacyPolicyService.getLastPrivacyPoliceVersion();
    PrivacyPolicyEntity? lastVersionSaved =
        await _privacyPolicyRepository.getLastVersionSaved();

    if (lastVersionSaved == null) {
      return await savePrivacyPolicy(lastVersionPrivacyPolicyFromServer);
    }
    if (lastVersionPrivacyPolicyFromServer != null) {
      return await compareVersion(
          lastVersionSaved, lastVersionPrivacyPolicyFromServer,);
    }

    return Future.value(null);
  }

  Future<PrivacyPolicyEntity?> savePrivacyPolicy(
      PrivacyPolicyEntity? lastVersionPrivacyPolicyFromServer,) async {
    if (lastVersionPrivacyPolicyFromServer == null) {
      return Future.value(null);
    }
    lastVersionPrivacyPolicyFromServer.dateTimeEventCreated = DateTime.now();
    lastVersionPrivacyPolicyFromServer.dateTimeEventRead = null;
    await _privacyPolicyRepository.save(
      privacyPolicy: lastVersionPrivacyPolicyFromServer,
    );
    return lastVersionPrivacyPolicyFromServer;
  }

  Future<PrivacyPolicyEntity?> compareVersion(
      lastVersionSaved, lastVersionPrivacyPolicyFromServer,) async {
    if (lastVersionSaved.version < lastVersionPrivacyPolicyFromServer.version) {
      return await savePrivacyPolicy(lastVersionPrivacyPolicyFromServer);
    }
    return Future.value(lastVersionSaved);
  }
}
