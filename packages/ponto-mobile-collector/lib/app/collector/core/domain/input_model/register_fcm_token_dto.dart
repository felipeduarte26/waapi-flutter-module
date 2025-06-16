import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/app/collector/core/domain/input_model/register_fcm_token_dto.g.dart';

@JsonSerializable()
class RegisterFCMTokenDto {
  String? token;
  String? employeeId;
  String? platform;

  RegisterFCMTokenDto({
    required this.token,
    required this.employeeId,
    required this.platform,
  });

  factory RegisterFCMTokenDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterFCMTokenDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterFCMTokenDtoToJson(this);
}
