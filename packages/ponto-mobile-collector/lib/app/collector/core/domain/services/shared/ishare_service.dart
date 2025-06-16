import 'package:share_plus/share_plus.dart';

abstract class IShareService {
  Future<void> shareString({
    required String text,
  });

  Future<void> shareFiles({
    required List<XFile> files,
  });
}
