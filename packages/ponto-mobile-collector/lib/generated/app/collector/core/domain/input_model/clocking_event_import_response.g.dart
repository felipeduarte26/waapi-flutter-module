// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/domain/input_model/clocking_event_import_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockingEventResponse _$ClockingEventResponseFromJson(
        Map<String, dynamic> json) =>
    ClockingEventResponse(
      importResult: ClockingEventsImportedDto.fromJson(
          json['importResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClockingEventResponseToJson(
        ClockingEventResponse instance) =>
    <String, dynamic>{
      'importResult': instance.importResult,
    };
