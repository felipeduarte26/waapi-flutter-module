import 'package:flutter_modular/flutter_modular.dart';
import '../../core/domain/services/navigator/navigator_service.dart';
import '../routes/privacy_policy_routes.dart';
import 'domain/presenter/cubit/privacy_policy_cubit.dart';
import 'domain/presenter/screens/privacy_policy_screen.dart';
import 'privacy_policy_binds.dart';

class PrivacyPolicyModule extends Module {
  String homePath;

  PrivacyPolicyModule({required this.homePath});
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        PrivacyPolicyBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/${PrivacyPolicyRoutes.home}',
          child: (context, args) => PrivacyPolicyScreen(
            cubit: Modular.get<PrivacyPolicyCubit>(),
            navigatorService: Modular.get<NavigatorService>(),
          ),
        ),
      ];
}
