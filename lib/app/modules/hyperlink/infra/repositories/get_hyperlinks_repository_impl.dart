import '../../../../core/types/either.dart';
import '../../domain/failures/hyperlink_failure.dart';
import '../../domain/repositories/get_hyperlinks_repository.dart';
import '../../domain/types/hyperlink_domain_types.dart';
import '../adapters/hyperlink_entity_adapter.dart';
import '../datasources/get_hyperlinks_datasource.dart';

class GetHyperlinksRepositoryImpl implements GetHyperlinksRepository {
  final GetHyperlinksDatasource _getHyperlinksDatasource;
  final HyperlinkEntityAdapter _hyperlinkEntityAdapter;

  GetHyperlinksRepositoryImpl({
    required GetHyperlinksDatasource getHyperlinksDatasource,
    required HyperlinkEntityAdapter hyperlinkEntityAdapter,
  })  : _getHyperlinksDatasource = getHyperlinksDatasource,
        _hyperlinkEntityAdapter = hyperlinkEntityAdapter;

  @override
  GetHyperlinksUsecaseCallback call({
    required String employeeId,
    required String userRoleId,
  }) async {
    try {
      final hyperlinksModel = await _getHyperlinksDatasource.call(
        employeeId: employeeId,
        userRoleId: userRoleId,
      );

      final hyperlinksEntities = hyperlinksModel.map(
        (hyperlinkModel) {
          return _hyperlinkEntityAdapter.fromModel(
            hyperlinkModel: hyperlinkModel,
          );
        },
      ).toList();

      return right(hyperlinksEntities);
    } catch (error) {
      return left(const HyperlinkDatasourceFailure());
    }
  }
}
