import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/edit_personal_documents_input_model.dart';
import '../../infra/datasources/update_personal_documents_datasource.dart';
import '../mappers/edit_personal_documents_input_model_mapper.dart';

class UpdatePersonalDocumentsDatasourceImpl implements UpdatePersonalDocumentsDatasource {
  final RestService _restService;
  final EditPersonalDocumentsInputModelMapper _editPersonalDocumentsInputModelMapper;

  const UpdatePersonalDocumentsDatasourceImpl({
    required RestService restService,
    required EditPersonalDocumentsInputModelMapper editPersonalDocumentsInputModelMapper,
  })  : _restService = restService,
        _editPersonalDocumentsInputModelMapper = editPersonalDocumentsInputModelMapper;

  @override
  Future<void> call({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  }) async {
    final bodyUpdatePersonalDocumentsModel = _editPersonalDocumentsInputModelMapper.toMap(
      editPersonalDocumentsInputModel: editPersonalDocumentsInputModel,
    );

    await _restService.legacyManagementPanelService().post(
          '/person-update-request',
          body: bodyUpdatePersonalDocumentsModel,
        );
  }
}
