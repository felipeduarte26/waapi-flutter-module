import 'dart:convert';


import '../../../../core/services/rest_client/rest_exception.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/happiness_index_failure.dart';
import '../../domain/repositories/retrieve_all_reasons_happiness_index_repository.dart';
import '../../domain/types/happiness_index_domain_types.dart';
import '../adapters/happiness_index_group_entity_adapter.dart';
import '../datasources/retrieve_all_reasons_happiness_index_datasource.dart';

class RetrieveAllReasonsHappinessIndexRepositoryImpl implements RetrieveAllReasonsHappinessIndexRepository {
  final RetrieveAllReasonsHappinessIndexDatasource _retrieveAllReasonsHappinessIndexDatasource;
  final HappinessIndexGroupEntityAdapter _groupEntityAdapter;
 

  const RetrieveAllReasonsHappinessIndexRepositoryImpl({
    required RetrieveAllReasonsHappinessIndexDatasource retrieveAllReasonsHappinessIndexDatasource,
    
    required HappinessIndexGroupEntityAdapter groupEntityAdapter,
  })  : _retrieveAllReasonsHappinessIndexDatasource = retrieveAllReasonsHappinessIndexDatasource,
        
        _groupEntityAdapter = groupEntityAdapter;

  @override
  RetrieveAllReasonsHappinessIndexUsecaseCallback call({
    required String language,
  }) async {
    try {
      final happinessIndexReasons = await _retrieveAllReasonsHappinessIndexDatasource.call(
        language: language,
      );

      final reasonsEntity = happinessIndexReasons.map(
        (reason) {
          return _groupEntityAdapter.fromModel(
            groupModel: reason,
          );
        },
      ).toList();

      return right(reasonsEntity);
    } catch (error) {


      String? messageError;

      if (error is RestException && error.response != null) {
        final messageResponse = jsonDecode(error.response!.data);
        messageError = messageResponse['message'] as String?;
      }

      return left(
        HappinessIndexDatasourceFailure(
          message: messageError,
        ),
      );
    }
  }
}
