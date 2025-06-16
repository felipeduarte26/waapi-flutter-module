import 'package:equatable/equatable.dart';

import 'social_profile_model.dart';

class SocialGroupModel extends Equatable {
  final String id;
  final String name;
  final String permaname;
  final List<SocialProfileModel>? profiles;
  final bool isSpaceGroup;

  const SocialGroupModel({
    required this.id,
    required this.name,
    required this.permaname,
    this.profiles,
    this.isSpaceGroup = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        permaname,
        profiles,
        isSpaceGroup,
      ];
}
