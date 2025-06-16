import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/search_person_failure.dart';
import '../../domain/repositories/search_person_by_term_repository.dart';
import '../../domain/types/search_person_domain_types.dart';
import '../adapters/person_entity_adapter.dart';
import '../datasources/search_person_by_term_datasource.dart';

class SearchPersonByTermRepositoryImpl implements SearchPersonByTermRepository {
  final SearchPersonByTermDatasource _searchPersonByTermDatasource;
 
  final PersonEntityAdapter _personEntityAdapter;

  const SearchPersonByTermRepositoryImpl({
    required SearchPersonByTermDatasource searchPersonByTermDatasource,
    
    required PersonEntityAdapter personEntityAdapter,
  })  : _searchPersonByTermDatasource = searchPersonByTermDatasource,
        
        _personEntityAdapter = personEntityAdapter;

  @override
  SearchPersonByTermUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final personModelList = await _searchPersonByTermDatasource.call(
        paginationRequirements: paginationRequirements,
      );

      final personEntityList = personModelList.map(
        (personModel) {
          return _personEntityAdapter.fromModel(
            personModel: personModel,
          );
        },
      ).toList();

      return right(personEntityList);
    } catch (error) {


      return left(const SearchPersonDatasourceFailure());
    }
  }
}
