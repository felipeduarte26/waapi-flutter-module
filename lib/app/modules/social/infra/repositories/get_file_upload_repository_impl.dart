
import '../../../../core/types/either.dart';
import '../../domain/entities/social_response_request_file_upload_entity.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/intput_models/social_request_file_upload_input_model.dart';
import '../../domain/repositories/get_file_upload_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_response_request_file_upload_entity_adapter.dart';
import '../datasources/get_file_upload_datasource.dart';
import '../datasources/storages3_amazonaws_datasource.dart';

class GetFileUploadRepositoryImpl implements GetFileUploadRepository {
  final GetFileUploadDatasource _getFileUploadDatasource;
  final Storages3AmazonawsDatasource _storages3AmazonawsDatasource;
 
  final SocialResponseRequestFileUploadEntityAdapter _fileUploadEntityAdapter;

  const GetFileUploadRepositoryImpl({
    required GetFileUploadDatasource getFileUploadDatasource,
    
    required SocialResponseRequestFileUploadEntityAdapter fileUploadEntityAdapter,
    required Storages3AmazonawsDatasource storages3AmazonawsDatasource,
  })  : _getFileUploadDatasource = getFileUploadDatasource,
        
        _fileUploadEntityAdapter = fileUploadEntityAdapter,
        _storages3AmazonawsDatasource = storages3AmazonawsDatasource;

  @override
  GetFileUploadUsecaseCallback call({
    required List<SocialRequestFileUploadInputModel> socialRequestFileUploadInputModelList,
  }) async {
    List<SocialResponseRequestFileUploadEntity> fileUploadEntityList = [];
    try {
      for (final socialRequestFileUploadInputModel in socialRequestFileUploadInputModelList) {
        final fileUploadModel = await _getFileUploadDatasource.call(
          socialResponseRequestFileUpload: socialRequestFileUploadInputModel,
        );
        final fileUploadEntity = _fileUploadEntityAdapter.fromModel(
          model: fileUploadModel,
        );
        final statusCode = await _storages3AmazonawsDatasource.call(
          socialResponseRequestFileUpload: socialRequestFileUploadInputModel,
          storages3awsUploadInputModel: fileUploadModel,
        );
        if (statusCode != '200') {
          return left(
            SocialRequestFileUploadFailure(),
          );
        } else {
          fileUploadEntityList.add(fileUploadEntity);
        }
      }

      return right(fileUploadEntityList);
    } catch (error) {


      return left(
        SocialRequestFileUploadFailure(),
      );
    }
  }
}
