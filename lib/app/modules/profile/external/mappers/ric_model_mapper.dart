import '../../../../core/helper/date_time_helper.dart';
import '../../infra/models/ric_model.dart';

class RicModelMapper {
  RicModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return RicModel(
      id: map['id'],
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      issuer: map['issuer'],
      issuingCityId: map['issuingCityId'],
      issuingCityName: map['issuingCityName'],
      number: map['number'],
    );
  }
}
