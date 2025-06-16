import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/intput_models/social_create_comment_intput_model.dart';
import '../../domain/repositories/create_comment_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_comments_entity_adapter.dart';
import '../datasources/create_comment_datasource.dart';
import '../datasources/read_attachment_download_url_datasource.dart';

class CreateCommentRepositoryImpl implements CreateCommentRepository {
  final CreateCommentDatasource _createCommentDatasource;
  final ReadAttachmentDownloadUrlDatasource _readAttachmentDownloadUrlDatasource;

  final SocialCommentsEntityAdapter _commentsEntityAdapter;

  const CreateCommentRepositoryImpl({
    required CreateCommentDatasource createCommentDatasource,
    required ReadAttachmentDownloadUrlDatasource readAttachmentDownloadUrlDatasource,
    required SocialCommentsEntityAdapter commentsEntityAdapter,
  })  : _createCommentDatasource = createCommentDatasource,
        _readAttachmentDownloadUrlDatasource = readAttachmentDownloadUrlDatasource,
        _commentsEntityAdapter = commentsEntityAdapter;

  @override
  CreateCommentUsecaseCallback call({
    required SocialCreateCommentIntputModel socialCreateCommentIntputModel,
  }) async {
    try {
      final commentModel = await _createCommentDatasource.call(
        socialCreateCommentIntputModel: socialCreateCommentIntputModel,
      );

      var commentsEntity = _commentsEntityAdapter.fromModel(
        model: commentModel,
      );

      if (commentsEntity.attachment != null && commentsEntity.attachment!.fileUrl.isEmpty) {
        final downloadUrl = await _readAttachmentDownloadUrlDatasource.call(
          attachmentId: commentsEntity.attachment!.id,
        );

        commentsEntity = commentsEntity.copyWith(
          attachment: commentsEntity.attachment!.copyWith(
            fileUrl: downloadUrl,
          ),
        );
      }
      return right(commentsEntity);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
