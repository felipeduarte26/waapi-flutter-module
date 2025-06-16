
import '../../domain/entities/privacy_policy_entity.dart';
import '../../domain/input_model/privacy_policy_dto.dart';

class PrivacyPolicyMapper {
  PrivacyPolicyDto fromMap(Map<String, dynamic> map) {
    return PrivacyPolicyDto(
      version: map['version'],
      urlVersion: map['url'],
    );
  }

  PrivacyPolicyEntity fromDtoToEntity({required PrivacyPolicyDto dto}) {
    return PrivacyPolicyEntity(
      version: dto.version,
      urlVersion: dto.urlVersion,
    );
  }
}
