abstract class AttachmentRoutes {
  // Module route name
  static const String attachmentModuleRoute = '/attachment';

  // Attachment screen routes name
  static const String attachmentScreenRoute = '/';
  static const String attachmentScreenInitialRoute = '$attachmentModuleRoute$attachmentScreenRoute';

  // Attachment pdf screen routes name
  static const String attachmentPdfScreenRoute = '/viewpdf';
  static const String attachmentPdfScreenInitialRoute = '$attachmentModuleRoute$attachmentPdfScreenRoute';
}
