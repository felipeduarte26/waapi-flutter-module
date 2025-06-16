import 'package:equatable/equatable.dart';

import '../../enums/social_network_provider_enum.dart';

class SocialNetworkModel extends Equatable {
  final String? id;
  final SocialNetworkProviderEnum? socialNetwork;
  final String? profile;

  const SocialNetworkModel({
    this.id,
    this.socialNetwork,
    this.profile,
  });

  @override
  List<Object?> get props {
    return [
      id,
      socialNetwork,
      profile,
    ];
  }
}
