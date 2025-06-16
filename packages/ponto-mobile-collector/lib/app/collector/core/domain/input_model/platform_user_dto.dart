import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/app/collector/core/domain/input_model/platform_user_dto.g.dart';

@JsonSerializable()
class PlatformUserDto {
  final String? id;
  final String username;

  PlatformUserDto({
    this.id,
    required this.username,
  });

  factory PlatformUserDto.fromJson(Map<String, dynamic> json) =>
      _$PlatformUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlatformUserDtoToJson(this);

}
