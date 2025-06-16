import '../../../../core/pagination/pagination_requirements.dart';
import '../models/person_model.dart';

abstract class SearchPersonByTermDatasource {
  Future<List<PersonModel>> call({
    required PaginationRequirements paginationRequirements,
  });
}
