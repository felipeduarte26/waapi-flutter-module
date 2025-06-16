// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/clocking_events_imported_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockingEventsImportedDto _$ClockingEventsImportedDtoFromJson(
        Map<String, dynamic> json) =>
    ClockingEventsImportedDto(
      clockingEventsImported: (json['clockingEventsImported'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      importErros: (json['importErros'] as List<dynamic>?)
          ?.map((e) =>
              ClockingEventImportErrorDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClockingEventsImportedDtoToJson(
        ClockingEventsImportedDto instance) =>
    <String, dynamic>{
      'clockingEventsImported': instance.clockingEventsImported,
      'importErros': instance.importErros,
    };
