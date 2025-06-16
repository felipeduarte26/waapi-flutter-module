// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/biometric_patterns.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiometricPatterns _$BiometricPatternsFromJson(Map<String, dynamic> json) =>
    BiometricPatterns(
      id: json['id'] as String,
      employee: json['employee'] as String,
      pattern: json['pattern'] as String,
      patternNumber: (json['patternNumber'] as num).toDouble(),
      vendor: json['vendor'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      platformId: json['platformId'] as String,
    );

Map<String, dynamic> _$BiometricPatternsToJson(BiometricPatterns instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employee': instance.employee,
      'pattern': instance.pattern,
      'patternNumber': instance.patternNumber,
      'vendor': instance.vendor,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'platformId': instance.platformId,
    };
