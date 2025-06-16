import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_education_degree_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../adapters/education_degree_entity_adapter.dart';
import '../datasources/get_education_degree_datasource.dart';

class GetEducationDegreeRepositoryImpl implements GetEducationDegreeRepository {
  final GetEducationDegreeDatasource _getEducationDegreeDatasource;
  final EducationDegreeEntityAdapter _educationDegreeEntityAdapter;

  const GetEducationDegreeRepositoryImpl({
    required GetEducationDegreeDatasource getEducationDegreeDatasource,
    required EducationDegreeEntityAdapter educationDegreeEntityAdapter,
  })  : _getEducationDegreeDatasource = getEducationDegreeDatasource,
        _educationDegreeEntityAdapter = educationDegreeEntityAdapter;

  @override
  GetEducationDegreeUsecaseCallback call() async {
    try {
      final getEducationDegreeModelList = await _getEducationDegreeDatasource.call();

      final getEducationDegreeEntityList = getEducationDegreeModelList.map(
        (educationDegreeModel) {
          return _educationDegreeEntityAdapter.fromModel(
            educationDegreeModel: educationDegreeModel,
          );
        },
      ).toList();

      return right(getEducationDegreeEntityList);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
