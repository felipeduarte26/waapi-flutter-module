import '../types/hyperlink_domain_types.dart';

abstract class GetHyperlinkPdfRepository {
  GetHyperlinkPdfUsecaseCallback call({
    required String pdfLink,
  });
}
