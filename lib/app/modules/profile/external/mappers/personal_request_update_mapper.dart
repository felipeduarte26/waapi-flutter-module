import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/personal_request_update_status_enum.dart';
import '../../infra/models/personal_request_update_model.dart';

class PersonalRequestUpdateMapper {
  PersonalRequestUpdateModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return PersonalRequestUpdateModel(
      id: (map['id'] != null || map['id'] != '') ? map['id'] : null,
      date: (map['date'] != null || map['date'] != '')
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: map['date'],
            )
          : null,
      status: EnumHelper<PersonalRequestUpdateStatusEnum>().stringToEnum(
        stringToParse: map['status'],
        values: PersonalRequestUpdateStatusEnum.values,
      ),
    );
  }

  PersonalRequestUpdateModel fromJson({required String personalRequestUpdateJson}) {
    return fromMap(
      map: json.decode(personalRequestUpdateJson),
    );
  }
}
