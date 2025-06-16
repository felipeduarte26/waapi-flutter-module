import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/helper/string_helper.dart';
import '../../../../../core/services/file/file_image_service.dart';
import '../../../domain/entities/social_attachment_entity.dart';
import '../../../domain/intput_models/social_attachment_input_model.dart';
import '../../../domain/intput_models/social_request_file_upload_input_model.dart';
import '../../../domain/usecases/get_file_upload_usecase.dart';
import '../../../enums/file_origin_enum.dart';
import '../../../enums/file_type_enum.dart';
import 'social_get_file_upload_event.dart';
import 'social_get_file_upload_state.dart';

class SocialGetFileUploadBloc extends Bloc<SocialGetFileUploadEvent, SocialGetFileUploadState> {
  final GetFileUploadUsecase _getFileUploadUsecase;
  final FileImageService _fileImageService;
  final Uuid _uuid;

  SocialGetFileUploadBloc({
    required GetFileUploadUsecase getFileUploadUsecase,
    required FileImageService fileImageService,
    required Uuid uuid,
  })  : _getFileUploadUsecase = getFileUploadUsecase,
        _fileImageService = fileImageService,
        _uuid = uuid,
        super(InitialSocialGetFileUploadState()) {
    on<SendFileUploadEvent>(_socialSendFileUploadEvent);
    on<GetFileUploadEvent>(_getSocialFileUploadEvent);
    on<DeleteFileUploadEvent>(_deleteSocialFileUploadEvent);
  }

  Future<void> _socialSendFileUploadEvent(
    SendFileUploadEvent event,
    Emitter<SocialGetFileUploadState> emit,
  ) async {
    emit(LoadingSocialGetFileUploadState());

    List<SocialRequestFileUploadInputModel> socialRequestFileUploadInputModelList = [];
    for (final socialAttachmentEntity in event.socialAttachmentEntityList) {
      socialRequestFileUploadInputModelList.add(
        SocialRequestFileUploadInputModel(
          id: socialAttachmentEntity.id,
          fileName: socialAttachmentEntity.fileName,
          fileSize: socialAttachmentEntity.fileSize,
          fileType: socialAttachmentEntity.contentType,
          fileBytes: socialAttachmentEntity.file!.readAsBytesSync(),
          filePath: socialAttachmentEntity.file!.path,
        ),
      );
    }
    List<SocialAttachmentInputModel> socialAttachmentInputModelList = [];
    for (final socialAttachmentEntity in event.socialAttachmentEntityList) {
      final ImageDimensions dimensions = await _fileImageService.getImageDimensions(
        socialAttachmentEntity.file!,
      );

      final int? height = dimensions.height;
      final int? width = dimensions.width;
      const excerpt = '...';
      const progress = 100;
      const success = true;

      socialAttachmentInputModelList.add(
        SocialAttachmentInputModel(
          height: height,
          width: width,
          excerpt: excerpt,
          progress: progress,
          contentType: socialAttachmentEntity.contentType,
          size: socialAttachmentEntity.fileSize,
          success: success,
          title: socialAttachmentEntity.title,
          type: socialAttachmentEntity.fileType,
          objectId: socialAttachmentEntity.id,
          objectVersion: '',
          fileName: socialAttachmentEntity.fileName,
          file: socialAttachmentEntity.file!,
        ),
      );
    }

    final fileUpload = await _getFileUploadUsecase.call(
      socialRequestFileUploadInputModelList: socialRequestFileUploadInputModelList,
    );

    fileUpload.fold(
      (left) {
        emit(
          ErrorSocialSendFileUploadState(),
        );
      },
      (right) {
        List<SocialAttachmentInputModel> socialAttachmentInputModelListSend = [];
        for (final socialResponseRequestFileUploadEntity in right) {
          for (final socialAttachmentInputModel in socialAttachmentInputModelList) {
            if (socialResponseRequestFileUploadEntity.id == socialAttachmentInputModel.objectId) {
              socialAttachmentInputModelListSend.add(
                socialAttachmentInputModel.copyWith(
                  objectId: socialResponseRequestFileUploadEntity.id,
                  objectVersion: socialResponseRequestFileUploadEntity.version,
                ),
              );
            }
          }
        }

        return emit(
          LoadedSocialSendFileUploadState(
            socialAttachmentInputModelList: socialAttachmentInputModelListSend,
          ),
        );
      },
    );
  }

  Future<void> _getSocialFileUploadEvent(
    GetFileUploadEvent event,
    Emitter<SocialGetFileUploadState> emit,
  ) async {
    final String contentType;
    final fileType = FileTypeEnumExtension.fromExtension(
      event.fileUpload.path.split('.').last,
    );
    final id = _uuid.v4().toLowerCase().replaceAll('-', '');
    if (event.fileOriginEnum == FileOriginEnum.camera || event.fileOriginEnum == FileOriginEnum.gallery) {
      contentType = 'image/jpeg';
    } else {
      contentType = StringHelper.getFileType(event.fileUpload.path.split('.').last);
    }
    final filename = event.fileUpload.path.split('/').last;

    return emit(
      LoadedSocialGetFileUploadState(
        file: event.fileUpload,
        fileOriginEnum: event.fileOriginEnum,
        socialAttachmentEntity: SocialAttachmentEntity(
          id: id,
          contentType: contentType,
          title: filename,
          fileName: filename,
          fileType: fileType,
          fileSize: event.fileUpload.lengthSync(),
          fileUrl: event.fileUpload.path,
          file: event.fileUpload,
        ),
      ),
    );
  }

  Future<void> _deleteSocialFileUploadEvent(
    DeleteFileUploadEvent event,
    Emitter<SocialGetFileUploadState> emit,
  ) async {
    emit(LoadingSocialGetFileUploadState());

    if (event.fileOriginEnum == FileOriginEnum.camera && event.fileUpload != null) {
      await event.fileUpload!.delete();
    }
    emit(
      DeleteSocialFileUploadState(
        id: event.id,
      ),
    );

    return emit(
      InitialSocialGetFileUploadState(),
    );
  }
}
