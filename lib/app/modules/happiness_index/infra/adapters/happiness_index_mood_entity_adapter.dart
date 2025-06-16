import '../../domain/entities/happiness_index_mood_entity.dart';
import '../models/happiness_index_mood_model.dart';
import 'happiness_index_group_entity_adapter.dart';

class HappinessIndexMoodEntityAdapter {
  HappinessIndexMoodEntity fromModel({
    required HappinessIndexMoodModel moodModel,
  }) {
    return HappinessIndexMoodEntity(
      note: moodModel.note,
      date: moodModel.date,
      happinessIndexMood: moodModel.happinessIndexMood,
      happinessIndexGroups: moodModel.happinessIndexGroups
          ?.map(
            (group) => HappinessIndexGroupEntityAdapter().fromModel(
              groupModel: group,
            ),
          )
          .toList(),
    );
  }
}
