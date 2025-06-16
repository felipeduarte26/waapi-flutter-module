import '../../../../core/helper/enum_helper.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../enums/happiness_index_mood_enum.dart';
import '../../infra/datasources/save_happiness_index_datasource.dart';

class SaveHappinessIndexDatasourceImpl implements SaveHappinessIndexDatasource {
  final RestService _restService;
  final EnumHelper<HappinessIndexMoodEnum> _enumHelper;

  const SaveHappinessIndexDatasourceImpl({
    required RestService restService,
    required EnumHelper<HappinessIndexMoodEnum> enumHelper,
  })  : _restService = restService,
        _enumHelper = enumHelper;

  @override
  Future<void> call({
    required HappinessIndexMoodEnum mood,
    required String language,
    required String notes,
    required List<String> reasons,
  }) async {
    await _restService.happinessIndexService().post(
      '/actions/registerMoodOfTheDay',
      body: {
        'mood': _enumHelper.enumToString(
          enumToParse: mood,
        ),
        'language': language,
        'notes': notes,
        'reasons': reasons
            .map(
              (reasonId) => reasonId,
            )
            .toList(),
      },
    );
  }
}
