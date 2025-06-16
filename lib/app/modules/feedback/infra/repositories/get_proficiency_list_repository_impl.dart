import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/get_proficiency_list_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../adapters/proficiency_feedback_entity_adapter.dart';
import '../datasources/get_proficiency_list_datasource.dart';

class GetProficiencyListRepositoryImpl implements GetProficiencyListRepository {
  final GetProficiencyListDatasource _getProficiencyListDatasource;
  final ProficiencyFeedbackEntityAdapter _proficiencyEntityAdapter;

  const GetProficiencyListRepositoryImpl({
    required GetProficiencyListDatasource getProficiencyListDatasource,
    required ProficiencyFeedbackEntityAdapter proficiencyEntityAdapter,
  })  : _getProficiencyListDatasource = getProficiencyListDatasource,
        _proficiencyEntityAdapter = proficiencyEntityAdapter;

  @override
  GetProficiencyListUsecaseCallback call() async {
    try {
      final proficiencyModelList = await _getProficiencyListDatasource.call();

      final proficiencyEntityList = proficiencyModelList.map(
        (proficiencyModel) {
          return _proficiencyEntityAdapter.fromModel(
            proficiencyFeedbackModel: proficiencyModel,
          );
        },
      ).toList();

      return right(proficiencyEntityList);
    } catch (error) {
      return left(const FeedbackProficiencyFailure());
    }
  }
}
