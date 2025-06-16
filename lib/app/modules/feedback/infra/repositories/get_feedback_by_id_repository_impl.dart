import 'dart:io';


import '../../../../core/services/rest_client/rest_exception.dart';
import '../../../../core/types/either.dart';
import '../../domain/failures/feedback_failure.dart';
import '../../domain/repositories/get_feedback_by_id_repository.dart';
import '../../domain/types/feedback_domain_types.dart';
import '../../enums/feedback_type_enum.dart';
import '../adapters/feedback_entity_adapter.dart';
import '../datasources/get_feedback_by_id_datasource.dart';

class GetFeedbackByIdRepositoryImpl implements GetFeedbackByIdRepository {
  final GetFeedbackByIdDatasource _getFeedbackByIdDatasource;
  final FeedbackEntityAdapter _feedbackEntityAdapter;
 

  const GetFeedbackByIdRepositoryImpl({
    required GetFeedbackByIdDatasource getFeedbackByIdDatasource,
    required FeedbackEntityAdapter feedbackEntityAdapter,
    
  })  : _getFeedbackByIdDatasource = getFeedbackByIdDatasource,
        _feedbackEntityAdapter = feedbackEntityAdapter;
        

  @override
  GetFeedbackByIdUsecaseCallback call({
    required String feedbackId,
    required FeedbackTypeEnum feedbackType,
  }) async {
    try {
      final feedbackModel = await _getFeedbackByIdDatasource.call(
        feedbackId: feedbackId,
        feedbackType: feedbackType,
      );

      final feedbackEntity = _feedbackEntityAdapter.fromModel(
        feedbackModel: feedbackModel,
      );

      return right(feedbackEntity);
    } on RestException catch (error, stackTrace) {
      if (error.statusCode == HttpStatus.notFound) {
        return left(
          FeedbackNotFoundFailure(
            message: error.message,
            stackTrace: stackTrace,
          ),
        );
      }



      return left(const FeedbackDatasourceFailure());
    } catch (error) {


      return left(const FeedbackDatasourceFailure());
    }
  }
}
