import '../../../../core/types/either.dart';
import '../../domain/input_models/send_vacation_request_update_input_model.dart';

abstract class SendVacationRequestUpdateDatasource {
  Future<Either<List<String>, Unit>> call({
    required SendVacationRequestUpdateInputModel sendVacationRequestUpdateInputModel,
  });
}
