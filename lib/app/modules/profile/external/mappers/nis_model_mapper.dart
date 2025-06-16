import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/nis_model.dart';

class NisModelMapper {
  NisModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return NisModel(
      id: map['id'],
      registrationDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['registrationDate'],
      ),
      number: map['number'],
    );
  }
}
