import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_person_id_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/get_person_id_datasource.dart';

class GetPersonIdRepositoryImpl implements GetPersonIdRepository {
  final GetPersonIdDatasource _getPersonIdDatasource;

  const GetPersonIdRepositoryImpl({
    required GetPersonIdDatasource getPersonIdDatasource,
  }) : _getPersonIdDatasource = getPersonIdDatasource;

  @override
  GetPersonIdUsecaseCallback call({
    required String employeeId,
  }) async {
    try {
      final personId = await _getPersonIdDatasource.call(
        employeeId: employeeId,
      );

      return right(personId);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
