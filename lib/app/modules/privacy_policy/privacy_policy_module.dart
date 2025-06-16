import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'presenter/screens/privacy_policy_screen.dart';

class PrivacyPolicyModule extends Module {
  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        PrivacyPolicyRoutes.privacyPolicyScreenRoute,
        child: (_, __) {
          return const PrivacyPolicyScreen();
        },
      ),
    ];
  }
}
