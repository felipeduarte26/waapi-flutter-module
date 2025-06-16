import '../../../../core/enums/brazilian_state_enum.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../infra/models/rg_model.dart';

class RgModelMapper {
  RgModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return RgModel(
      id: map['id'],
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      issuer: map['issuer'],
      issuingState: EnumHelper<BrazilianStateEnum>().stringToEnum(
        stringToParse: map['issuingState'],
        values: BrazilianStateEnum.values,
      ),
      number: map['number'],
    );
  }
}
