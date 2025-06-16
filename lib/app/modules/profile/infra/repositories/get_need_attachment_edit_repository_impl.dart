import '../../../../core/types/either.dart';
import '../../domain/failures/profile_failure.dart';
import '../../domain/repositories/get_need_attachment_edit_repository.dart';
import '../../domain/types/profile_domain_types.dart';
import '../datasources/get_need_attachment_edit_datasource.dart';

class GetNeedAttachmentEditRepositoryImpl implements GetNeedAttachmentEditRepository {
  final GetNeedAttachmentEditDatasource _getNeedAttachmentEditDatasource;

  const GetNeedAttachmentEditRepositoryImpl({
    required GetNeedAttachmentEditDatasource getNeedAttachmentEditDatasource,
  }) : _getNeedAttachmentEditDatasource = getNeedAttachmentEditDatasource;

  @override
  GetNeedAttachmentEditUsecaseCallback call({
    required String role,
  }) async {
    try {
      final needAttachmentEdit = await _getNeedAttachmentEditDatasource.call(
        role: role,
      );

      return right(needAttachmentEdit);
    } catch (error) {
      return left(const ProfileDatasourceFailure());
    }
  }
}
