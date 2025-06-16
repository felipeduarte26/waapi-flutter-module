import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/edit_personal_diversity_input_model.dart';
import '../../infra/datasources/update_personal_diversity_datasource.dart';
import '../mappers/edit_personal_diversity_input_model_mapper.dart';

class UpdatePersonalDiversityDatasourceImpl implements UpdatePersonalDiversityDatasource {
  final RestService _restService;
  final EditPersonalDiversityInputModelMapper _editPersonalDiversityInputModelMapper;

  const UpdatePersonalDiversityDatasourceImpl({
    required RestService restService,
    required EditPersonalDiversityInputModelMapper editPersonalDiversityInputModelMapper,
  })  : _restService = restService,
        _editPersonalDiversityInputModelMapper = editPersonalDiversityInputModelMapper;

  @override
  Future<void> call({
    required EditPersonalDiversityInputModel editPersonalDiversityInputModel,
  }) async {
    final bodyUpdatePersonalDiversityModel = _editPersonalDiversityInputModelMapper.toMap(
      editPersonalDiversityInputModel: editPersonalDiversityInputModel,
    );

    await _restService.diversityService().patch(
          '/entities/person',
          body: bodyUpdatePersonalDiversityModel,
        );
  }
}
