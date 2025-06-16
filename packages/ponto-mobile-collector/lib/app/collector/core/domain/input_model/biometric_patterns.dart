import 'package:json_annotation/json_annotation.dart';

part '../../../../../generated/app/collector/core/domain/input_model/biometric_patterns.g.dart';

@JsonSerializable()
class BiometricPatterns {
  final String id;
  final String employee;
  final String pattern;
  final double patternNumber;
  final String vendor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String platformId;

  BiometricPatterns({
    required this.id,
    required this.employee,
    required this.pattern,
    required this.patternNumber,
    required this.vendor,
    required this.createdAt,
    required this.updatedAt,
    required this.platformId,
  });

  factory BiometricPatterns.fromJson(Map<String, dynamic> json) =>
      _$BiometricPatternsFromJson(json);

  Map<String, dynamic> toJson() => _$BiometricPatternsToJson(this);
}
