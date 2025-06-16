import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/input_models/edit_personal_documents_input_model.dart';
import '../../domain/repositories/update_personal_documents_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/update_personal_documents_datasource.dart';

class UpdatePersonalDocumentsRepositoryImpl implements UpdatePersonalDocumentsRepository {
  final UpdatePersonalDocumentsDatasource _updatePersonalDocumentsDatasource;

  const UpdatePersonalDocumentsRepositoryImpl({
    required UpdatePersonalDocumentsDatasource updatePersonalDocumentsDatasource,
  }) : _updatePersonalDocumentsDatasource = updatePersonalDocumentsDatasource;

  @override
  UpdatePersonalDocumentsUsecaseCallback call({
    required EditPersonalDocumentsInputModel editPersonalDocumentsInputModel,
  }) async {
    try {
      await _updatePersonalDocumentsDatasource.call(
        editPersonalDocumentsInputModel: editPersonalDocumentsInputModel,
      );
      return right(unit);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
