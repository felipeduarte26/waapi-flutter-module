enum FileTypeEnum {
  unknown,
  pdf,
  msWord,
  msExcel,
  msPowerPoint,
  msVisio,
  msOutlook,
  msPublisher,
  ooxmlWord,
  ooxmlExcel,
  ooxmlPowerPoint,
  ooxmlVisio,
  plainText,
  image,
  video,
  audio,
}

extension FileTypeEnumExtension on FileTypeEnum {
  static FileTypeEnum fromExtension(String extension) {
    extension.toLowerCase();
    switch (extension.toLowerCase()) {
      case 'pdf':
        return FileTypeEnum.pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
        return FileTypeEnum.image;
      case 'mp4':
      case 'avi':
      case 'mkv':
        return FileTypeEnum.video;
      case 'mp3':
      case 'wav':
      case 'aac':
      case 'flac':
        return FileTypeEnum.audio;
      case 'txt':
        return FileTypeEnum.unknown;
      case 'doc':
        return FileTypeEnum.msWord;
      case 'docx':
        return FileTypeEnum.ooxmlWord;
      case 'xls':
        return FileTypeEnum.msExcel;
      case 'xlsx':
        return FileTypeEnum.ooxmlExcel;
      case 'ppt':
        return FileTypeEnum.msPowerPoint;
      case 'pptx':
        return FileTypeEnum.ooxmlPowerPoint;
      case 'vsd':
        return FileTypeEnum.msVisio;
      case 'vsdx':
        return FileTypeEnum.ooxmlVisio;
      case 'msg':
        return FileTypeEnum.msOutlook;
      case 'pub':
        return FileTypeEnum.msPublisher;
      default:
        return FileTypeEnum.unknown;
    }
  }

  String description() {
    switch (this) {
      case FileTypeEnum.unknown:
        return 'Unknown';
      case FileTypeEnum.pdf:
        return 'PDF';
      case FileTypeEnum.msWord:
        return 'MSWord';
      case FileTypeEnum.msExcel:
        return 'MSExcel';
      case FileTypeEnum.msPowerPoint:
        return 'MSPowerPoint';
      case FileTypeEnum.msVisio:
        return 'MSVisio';
      case FileTypeEnum.msOutlook:
        return 'MSOutlook';
      case FileTypeEnum.msPublisher:
        return 'MSPublisher';
      case FileTypeEnum.ooxmlWord:
        return 'OoxmlWord';
      case FileTypeEnum.ooxmlExcel:
        return 'OoxmlExcel';
      case FileTypeEnum.ooxmlPowerPoint:
        return 'OoxmlPowerPoint';
      case FileTypeEnum.ooxmlVisio:
        return 'OoxmlVisio';
      case FileTypeEnum.plainText:
        return 'PlainText';
      case FileTypeEnum.image:
        return 'Image';
      case FileTypeEnum.video:
        return 'Video';
      case FileTypeEnum.audio:
        return 'Audio';
      default:
        return 'Unknown';
    }
  }
}
