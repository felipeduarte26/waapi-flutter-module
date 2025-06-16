import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/edit_personal_address_input_model.dart';
import '../../infra/datasources/update_personal_address_datasource.dart';
import '../mappers/edit_personal_address_input_model_mapper.dart';

class UpdatePersonalAddressDatasourceImpl implements UpdatePersonalAddressDatasource {
  final RestService _restService;
  final EditPersonalAddressInputModelMapper _editPersonalAddressInputModelMapper;

  const UpdatePersonalAddressDatasourceImpl({
    required RestService restService,
    required EditPersonalAddressInputModelMapper editPersonalAddressInputModelMapper,
  })  : _restService = restService,
        _editPersonalAddressInputModelMapper = editPersonalAddressInputModelMapper;

  @override
  Future<void> call({
    required EditPersonalAddressInputModel editPersonalAddressInputModel,
  }) async {
    final bodyUpdatePersonalAddressModel = _editPersonalAddressInputModelMapper.toMap(
      editPersonalAddressInputModel: editPersonalAddressInputModel,
    );

    await _restService.legacyManagementPanelService().post(
          '/person-update-request',
          body: bodyUpdatePersonalAddressModel,
        );
  }
}
