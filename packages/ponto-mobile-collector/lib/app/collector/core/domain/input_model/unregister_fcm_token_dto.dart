import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/app/collector/core/domain/input_model/unregister_fcm_token_dto.g.dart';

@JsonSerializable()
class UnregisterFCMTokenDto {
  String? employeeId;
  String? platform;

  UnregisterFCMTokenDto({
    required this.employeeId,
    required this.platform,
  });

  factory UnregisterFCMTokenDto.fromJson(Map<String, dynamic> json) =>
      _$UnregisterFCMTokenDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UnregisterFCMTokenDtoToJson(this);
}
