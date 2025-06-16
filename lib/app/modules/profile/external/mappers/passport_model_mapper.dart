import '../../../../core/enums/brazilian_state_enum.dart';
import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../infra/models/passport_model.dart';

class PassportModelMapper {
  PassportModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PassportModel(
      id: map['id'],
      expiryDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['expiryDate'],
      ),
      issuedDate: DateTimeHelper.convertStringAaaaMmDdToDateTime(
        stringToConvert: map['issuedDate'],
      ),
      issuer: map['issuer'],
      issuingAuthority: map['issuingAuthority'],
      issuingCountryId: map['issuingCountryId'],
      issuingCountryName: map['issuingCountryName'],
      issuingState: EnumHelper<BrazilianStateEnum>().stringToEnum(
        stringToParse: map['issuingState'],
        values: BrazilianStateEnum.values,
      ),
      number: map['number'],
    );
  }
}
