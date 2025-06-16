import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_spaces_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_space_entity_adapter.dart';
import '../datasources/get_spaces_datasource.dart';

class GetSpacesRepositoryImpl implements GetSpacesRepository {
  final GetSpacesDatasource _getSpacesDatasource;
 
  final SocialSpaceEntityAdapter _spaceEntityAdapter;

  GetSpacesRepositoryImpl({
    required GetSpacesDatasource getSpacesDatasource,
    
    required SocialSpaceEntityAdapter spaceEntityAdapter,
  })  : _getSpacesDatasource = getSpacesDatasource,
        
        _spaceEntityAdapter = spaceEntityAdapter;

  @override
  GetSpacesUsecaseCallback call({required PaginationRequirements paginationRequirements}) async {
    try {
      final spaceList = await _getSpacesDatasource.call(paginationRequirements: paginationRequirements);

      final spaceEntityList = spaceList.map((space) => _spaceEntityAdapter.fromModel(spaceModel: space)).toList();

      return right(spaceEntityList);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
