import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/rne_model.dart';

class RneModelMapper {
  RneModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return RneModel(
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      issuer: map['issuer'],
      number: map['number'],
    );
  }
}
