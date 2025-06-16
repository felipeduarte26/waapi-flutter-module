import '../../../../core/types/either.dart';
import '../entities/hyperlink_entity.dart';
import '../failures/hyperlink_failure.dart';

typedef GetHyperlinksUsecaseCallback = Future<Either<HyperlinkFailure, List<HyperlinkEntity>>>;
typedef GetHyperlinkPdfUsecaseCallback = Future<Either<HyperlinkFailure, List<int>>>;
