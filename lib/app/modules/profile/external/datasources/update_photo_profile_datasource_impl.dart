import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/update_photo_profile_datasource.dart';

class UpdatePhotoProfileDatasourceImpl implements UpdatePhotoProfileDatasource {
  final RestService _restService;

  const UpdatePhotoProfileDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String userId,
    required String photoBase64,
    required String contentType,
  }) async {
    final pathUrl = '/person/$userId/photo/attachment';
    final newPhotoJsonResult = await _restService.legacyManagementPanelService().post(
      pathUrl,
      body: {
        'photo': photoBase64,
        'contentType': contentType,
      },
    );

    final resultDecoded = jsonDecode(newPhotoJsonResult.data!);

    return resultDecoded['standard'];
  }
}
