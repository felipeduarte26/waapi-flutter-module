import 'dart:convert';

import '../../../../core/helper/enum_helper.dart';
import '../../enums/social_profile_type_enum.dart';
import '../../infra/models/social_profile_model.dart';
import 'social_space_model_mapper.dart';

class SocialProfileModelMapper {
  SocialProfileModel fromMap({
    required Map<String, dynamic> authorMap,
  }) {
    return SocialProfileModel(
      name: authorMap['name'],
      avatarUrl: authorMap['avatarUrl'],
      id: authorMap['id'],
      permaname: authorMap['permaname'],
      hasAvatar: authorMap['hasAvatar'],
      profileType: authorMap['profileType'] != null
          ? EnumHelper<SocialProfileTypeEnum>().stringToEnum(
                stringToParse: authorMap['profileType'],
                values: SocialProfileTypeEnum.values,
              ) ??
              SocialProfileTypeEnum.unknown
          : null,
      spaces: (authorMap['spaces'] != null && (authorMap['spaces'] as List<dynamic>).isNotEmpty)
          ? (authorMap['spaces'] as List<dynamic>).map(
              (space) {
                return SocialSpaceModelMapper().fromMap(
                  map: space,
                );
              },
            ).toList()
          : null,
      tags: (authorMap['tags'] != null && (authorMap['tags'] as List<dynamic>).isNotEmpty)
          ? List<String>.from(
              authorMap['tags'],
            )
          : null,
    );
  }

  List<SocialProfileModel> fromListProfilesThatLiked({
    required Map<String, dynamic> profilesThatLikedMap,
  }) {
    return (profilesThatLikedMap['profilesThatLiked'] as List<dynamic>?)?.map(
          (member) {
            return fromMap(
              authorMap: member,
            );
          },
        ).toList() ??
        const [];
  }

  List<SocialProfileModel> fromListMap({
    required Map<String, dynamic> memberMap,
  }) {
    return (memberMap['members'] as List<dynamic>?)?.map(
          (member) {
            return fromMap(
              authorMap: member,
            );
          },
        ).toList() ??
        const [];
  }

  List<SocialProfileModel> fromListProfilesMap({
    required Map<String, dynamic> mentionMap,
  }) {
    return (mentionMap['profiles'] as List<dynamic>?)?.map(
          (mention) {
            return fromMap(
              authorMap: mention,
            );
          },
        ).toList() ??
        const [];
  }

  SocialProfileModel fromProfileMap({required Map<String, dynamic> profileMap}) {
    return fromMap(
      authorMap: profileMap['profile'],
    );
  }

  SocialProfileModel fromJson({
    required String json,
  }) {
    return fromMap(
      authorMap: jsonDecode(
        json,
      ),
    );
  }

  SocialProfileModel fromProfileJson({
    required String json,
  }) {
    return fromProfileMap(
      profileMap: jsonDecode(
        json,
      ),
    );
  }
}
