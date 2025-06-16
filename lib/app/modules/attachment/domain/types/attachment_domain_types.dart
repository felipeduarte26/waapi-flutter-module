import '../../../../core/types/either.dart';
import '../entities/attachment_entity.dart';
import '../failures/attachment_failure.dart';

typedef GetUploadedAttachmentsUsecaseCallback = Future<Either<AttachmentFailure, AttachmentEntity>>;
typedef DeleteAttachmentUsecaseCallback = Future<Either<AttachmentFailure, Unit>>;
typedef ShareFileUsecaseCallback = Future<Either<AttachmentFailure, Unit>>;
typedef DownloadAttachmentUsecaseCallback = Future<Either<AttachmentFailure, List<int>>>;
typedef GetNativePermissionStorageUsecaseCallback = Future<Either<AttachmentFailure, Unit>>;
typedef ShareStringUsecaseCallback = Future<Either<AttachmentFailure, Unit>>;
