import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/edit_personal_data_input_model.dart';
import '../../infra/datasources/update_personal_data_datasource.dart';
import '../mappers/edit_personal_data_input_model_mapper.dart';

class UpdatePersonalDataDatasourceImpl implements UpdatePersonalDataDatasource {
  final RestService _restService;
  final EditPersonalDataInputModelMapper _editPersonalDataInputModelMapper;

  const UpdatePersonalDataDatasourceImpl({
    required RestService restService,
    required EditPersonalDataInputModelMapper editPersonalDataInputModelMapper,
  })  : _restService = restService,
        _editPersonalDataInputModelMapper = editPersonalDataInputModelMapper;

  @override
  Future<void> call({
    required EditPersonalDataInputModel editPersonalDataInputModel,
  }) async {
    final bodyUpdatePersonalDataModel = _editPersonalDataInputModelMapper.toMap(
      editPersonalDataInputModel: editPersonalDataInputModel,
    );

    await _restService.legacyManagementPanelService().post(
          '/person-update-request',
          body: bodyUpdatePersonalDataModel,
        );
  }
}
