import '../../../../core/types/either.dart';
import '../../domain/input_models/send_vacation_request_input_model.dart';

abstract class SendVacationRequestDatasource {
  Future<Either<List<String>, Unit>> call({
    required SendVacationRequestInputModel sendVacationRequestInputModel,
  });
}
