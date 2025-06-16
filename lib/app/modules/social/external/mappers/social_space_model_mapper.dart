import 'dart:convert';

import '../../../../core/helper/date_time_helper.dart';
import '../../../../core/helper/enum_helper.dart';
import '../../enums/social_space_membership_enum.dart';
import '../../enums/social_space_privacy_enum.dart';
import '../../infra/models/social_space_model.dart';
import 'social_owner_space_model_mapper.dart';

class SocialSpaceModelMapper {
  SocialSpaceModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialSpaceModel(
      name: map['name'],
      permaname: map['permaname'],
      createdAt: map['createdAt'] != null
          ? DateTimeHelper.convertStringAaaaMmDdToDateTime(
              stringToConvert: map['createdAt'],
            )
          : null,
      isAdmin: map['isAdmin'],
      isMember: map['isMember'] != null
          ? SocialSpaceMembershipEnumExtension.fromString(
              map['isMember'],
            )
          : null,
      owner: map['owner'] != null
          ? SocialOwnerSpaceModelMapper().fromMap(
              map: map['owner'],
            )
          : null,
      privacy: map['privacy'] != null
          ? EnumHelper<SocialSpacePrivacyEnum>().stringToEnum(
                stringToParse: map['privacy'],
                values: SocialSpacePrivacyEnum.values,
              ) ??
              SocialSpacePrivacyEnum.unknown
          : null,
      spaceId: map['id'],
      memberCount: map['memberCount'],
    );
  }

  SocialSpaceModel fromJson({
    required String json,
  }) {
    if (json.isEmpty) {
      return fromMap(map: {});
    } else {
      final jsonDecoded = jsonDecode(json);
      return fromMap(
        map: jsonDecoded['space'],
      );
    }
  }
}
