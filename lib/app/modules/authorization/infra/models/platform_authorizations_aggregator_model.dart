import 'package:equatable/equatable.dart';

import 'platform_authorization_model.dart';

class PlatformAuthorizationsAggregatorModel extends Equatable {
  final List<PlatformAuthorizationModel> platformAuthorizations;

  const PlatformAuthorizationsAggregatorModel({
    required this.platformAuthorizations,
  });

  @override
  List<Object> get props {
    return [
      platformAuthorizations,
    ];
  }
}
