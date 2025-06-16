import 'dart:convert';

import '../../../../core/helper/enum_helper.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/input_models/dependent_dto_input_model.dart';
import '../../enums/request_type_enum.dart';
import '../../infra/datasources/update_dependents_datasource.dart';
import '../mappers/dependent_dto_input_model_mapper.dart';

class UpdateDependentsDatasourceImpl implements UpdateDependentsDatasource {
  final RestService _restService;
  final DependentDtoInputModelMapper _dependentDtoInputModelMapper;

  const UpdateDependentsDatasourceImpl({
    required RestService restService,
    required DependentDtoInputModelMapper dependentDtoInputModelMapper,
  })  : _restService = restService,
        _dependentDtoInputModelMapper = dependentDtoInputModelMapper;

  @override
  Future<void> call({
    required DependentDtoInputModel dependentDtoInputModel,
  }) async {
    final sendDependentsInputModel = jsonEncode(
      _dependentDtoInputModelMapper.toMap(
        dependentDtoInputModel: dependentDtoInputModel,
      ),
    );

    if (!_hasDependentId(dependentDtoInputModel.editDependentsInputModel.id) ||
        _isDependent(
          dependentDtoInputModel.editDependentsInputModel.requestUpdateId,
          dependentDtoInputModel.editDependentsInputModel.id,
          EnumHelper<RequestTypeEnum>()
              .stringToEnum(stringToParse: dependentDtoInputModel.requestType, values: RequestTypeEnum.values),
        )) {
      await _restService.legacyManagementPanelService().post(
            '/dependent-update-request/request-update/${dependentDtoInputModel.editDependentsInputModel.employeeId}',
            body: sendDependentsInputModel,
          );

      return;
    } else if (_hasRequestUpdateId(dependentDtoInputModel.editDependentsInputModel.requestUpdateId)) {
      await _restService.legacyManagementPanelService().put(
            '/dependent-update-request/request-update/${dependentDtoInputModel.editDependentsInputModel.requestUpdateId}',
            body: sendDependentsInputModel,
          );

      return;
    }

    await _restService.legacyManagementPanelService().put(
          '/dependent-update-request/request-update/${dependentDtoInputModel.editDependentsInputModel.id}',
          body: sendDependentsInputModel,
        );
  }

  bool _hasDependentId(String dependentId) {
    return dependentId.isNotEmpty;
  }

  bool _hasRequestUpdateId(String? requestUpdateId) {
    return requestUpdateId != null && requestUpdateId.isNotEmpty;
  }

  bool _isDependent(String? requestUpdateId, String dependentId, RequestTypeEnum? requestTypeEnum) {
    return !_hasRequestUpdateId(requestUpdateId) &&
        _hasDependentId(dependentId) &&
        requestTypeEnum == RequestTypeEnum.update;
  }
}
