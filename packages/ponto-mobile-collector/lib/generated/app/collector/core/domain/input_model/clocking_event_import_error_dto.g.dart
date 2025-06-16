// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/clocking_event_import_error_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockingEventImportErrorDto _$ClockingEventImportErrorDtoFromJson(
        Map<String, dynamic> json) =>
    ClockingEventImportErrorDto(
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      clockingEvent: json['clockingEvent'] == null
          ? null
          : ClockingEventDto.fromJson(
              json['clockingEvent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClockingEventImportErrorDtoToJson(
        ClockingEventImportErrorDto instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'clockingEvent': instance.clockingEvent,
    };
