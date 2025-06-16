import '../../../../core/types/either.dart';
import '../../domain/failures/hyperlink_failure.dart';
import '../../domain/repositories/get_hyperlink_pdf_repository.dart';
import '../../domain/types/hyperlink_domain_types.dart';
import '../datasources/get_hyperlink_pdf_path_datasource.dart';

class GetHyperlinkPdfRepositoryImpl implements GetHyperlinkPdfRepository {
  final GetHyperlinkPdfPathDatasource _getHyperlinkPdfDatasource;

  GetHyperlinkPdfRepositoryImpl({
    required GetHyperlinkPdfPathDatasource getHyperlinkPdfDatasource,
  }) : _getHyperlinkPdfDatasource = getHyperlinkPdfDatasource;

  @override
  GetHyperlinkPdfUsecaseCallback call({
    required String pdfLink,
  }) async {
    try {
      final resultFile = await _getHyperlinkPdfDatasource.call(
        pdfLink: pdfLink,
      );

      return right(resultFile);
    } catch (error) {
      return left(const HyperlinkDatasourceFailure());
    }
  }
}
