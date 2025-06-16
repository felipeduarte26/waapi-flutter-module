import 'package:equatable/equatable.dart';

class EditPersonalContactSocialNetworkInputModel extends Equatable {
  final String? id;
  final String? personId;
  final String socialNetwork;
  final String socialNetworkName;
  final String profile;
  final String? personRequestUpdateType;

  const EditPersonalContactSocialNetworkInputModel({
    this.id,
    this.personId,
    required this.socialNetwork,
    required this.socialNetworkName,
    required this.profile,
    this.personRequestUpdateType,
  });

  @override
  List<Object?> get props {
    return [
      id,
      personId,
      socialNetwork,
      socialNetworkName,
      profile,
      personRequestUpdateType,
    ];
  }
}
