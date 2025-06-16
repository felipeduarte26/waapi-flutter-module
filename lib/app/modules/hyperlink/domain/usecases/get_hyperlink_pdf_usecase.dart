import '../repositories/get_hyperlink_pdf_repository.dart';
import '../types/hyperlink_domain_types.dart';

abstract class GetHyperlinkPdfUsecase {
  GetHyperlinkPdfUsecaseCallback call({
    required String pdfLink,
  });
}

class GetHyperlinkPdfUsecaseImpl implements GetHyperlinkPdfUsecase {
  final GetHyperlinkPdfRepository _getHyperlinkPdfRepository;

  const GetHyperlinkPdfUsecaseImpl({
    required GetHyperlinkPdfRepository getHyperlinkPdfPathRepository,
  }) : _getHyperlinkPdfRepository = getHyperlinkPdfPathRepository;

  @override
  GetHyperlinkPdfUsecaseCallback call({
    required String pdfLink,
  }) {
    return _getHyperlinkPdfRepository.call(
      pdfLink: pdfLink,
    );
  }
}
