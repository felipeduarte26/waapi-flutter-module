import 'dart:convert';

import '../../../../core/helper/enum_helper.dart';

import '../../../../core/services/rest_client/rest_exception.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/happiness_index_failure.dart';
import '../../domain/repositories/save_happiness_index_repository.dart';
import '../../domain/types/happiness_index_domain_types.dart';
import '../../enums/happiness_index_mood_enum.dart';
import '../datasources/save_happiness_index_datasource.dart';

class SaveHappinessIndexRepositoryImpl implements SaveHappinessIndexRepository {
  final SaveHappinessIndexDatasource _saveHappinessIndexDatasource;

  final EnumHelper<HappinessIndexMoodEnum> _enumHelper;

  const SaveHappinessIndexRepositoryImpl({
    required SaveHappinessIndexDatasource saveHappinessIndexDatasource,
    required EnumHelper<HappinessIndexMoodEnum> enumHelper,
  })  : _saveHappinessIndexDatasource = saveHappinessIndexDatasource,
        _enumHelper = enumHelper;

  @override
  SaveHappinessIndexUsecaseCallback call({
    required HappinessIndexMoodEnum mood,
    required String language,
    required String notes,
    required List<String> reasons,
  }) async {
    try {
      await _saveHappinessIndexDatasource.call(
        mood: mood,
        language: language,
        notes: notes,
        reasons: reasons,
      );
      return right(unit);
    } catch (error) {
      String? messageError;

      if (error is RestException && error.response != null) {
        final messageResponse = jsonDecode(error.response!.data);
        messageError = messageResponse['message'] as String?;
      }

      return left(
        HappinessIndexDatasourceFailure(
          message: messageError,
        ),
      );
    }
  }

  Map<String, dynamic> getAnalyticsParameters({
    required HappinessIndexMoodEnum mood,
    required String language,
  }) {
    return {
      'language': language,
      'mood': _enumHelper
          .enumToString(
            enumToParse: mood,
          )
          .toLowerCase(),
    };
  }
}
