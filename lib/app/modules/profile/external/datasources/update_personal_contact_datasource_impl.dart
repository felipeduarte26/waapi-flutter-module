import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/edit_personal_contact_input_model.dart';
import '../../infra/datasources/update_personal_contact_datasource.dart';
import '../mappers/edit_personal_contact_input_model_mapper.dart';

class UpdatePersonalContactDatasourceImpl implements UpdatePersonalContactDatasource {
  final RestService _restService;
  final EditPersonalContactInputModelMapper _editPersonalContactInputModelMapper;

  const UpdatePersonalContactDatasourceImpl({
    required RestService restService,
    required EditPersonalContactInputModelMapper editPersonalContactInputModelMapper,
  })  : _restService = restService,
        _editPersonalContactInputModelMapper = editPersonalContactInputModelMapper;

  @override
  Future<void> call({
    required EditPersonalContactInputModel editPersonalContactInputModel,
  }) async {
    final bodyUpdatePersonalContactModel = _editPersonalContactInputModelMapper.toMap(
      editPersonalContactInputModel: editPersonalContactInputModel,
    );

    await _restService.legacyManagementPanelService().post(
          '/person-update-request',
          body: bodyUpdatePersonalContactModel,
        );
  }
}
