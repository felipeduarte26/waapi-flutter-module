import '../../../../core/enums/brazilian_state_enum.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../infra/models/ctps_model.dart';

class CtpsModelMapper {
  CtpsModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return CtpsModel(
      id: map['id'],
      number: map['number'],
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      serieDigit: map['serieDigit'],
      serie: map['serie'],
      state: EnumHelper<BrazilianStateEnum>().stringToEnum(
        stringToParse: map['state'],
        values: BrazilianStateEnum.values,
      ),
    );
  }
}
