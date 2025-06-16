import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/happiness_index_mood_enum.dart';
import '../../infra/models/happiness_index_mood_model.dart';
import 'happiness_index_group_model_mapper.dart';

class HappinessIndexMoodModelMapper {
  final HappinessIndexGroupModelMapper _groupModelMapper;

  const HappinessIndexMoodModelMapper({
    required HappinessIndexGroupModelMapper groupModelMapper,
  }) : _groupModelMapper = groupModelMapper;

  HappinessIndexMoodModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return HappinessIndexMoodModel(
      note: map['notes'],
      date: convertedDate(map['dateMood']),
      happinessIndexGroups: map['groupReason'] != null
          ? (map['groupReason'] as List).map(
              (subgroup) {
                return _groupModelMapper.fromMap(map: subgroup);
              },
            ).toList()
          : null,
      happinessIndexMood: EnumHelper<HappinessIndexMoodEnum>().stringToEnum(
            stringToParse: map['mood'] ?? '',
            values: HappinessIndexMoodEnum.values,
          ) ??
          HappinessIndexMoodEnum.neutral,
    );
  }

  DateTime convertedDate(String datetime) {
    try {
      final dDateTime = DateTime.parse(datetime);
      if (dDateTime.hour != 0 || dDateTime.minute != 0 || dDateTime.second != 0) {
        return DateTimeHelper.convertStringIso8601toDateTime(
          stringIso8601: datetime,
          adjustTimeZone: true,
        );
      }

      return DateTimeHelper.convertStringIso8601toDateTime(
        stringIso8601: datetime,
      );
    } catch (_) {
      return DateTime(1970, 1, 1);
    }
  }
}
