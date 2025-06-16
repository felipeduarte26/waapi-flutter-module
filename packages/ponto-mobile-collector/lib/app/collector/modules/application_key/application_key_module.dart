import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../generated/l10n/collector_localizations.dart';
import '../../core/domain/services/navigator/navigator_service.dart';
import '../routes/application_key_routes.dart';
import 'application_key_binds.dart';
import 'presenter/cubit/application_key_cubit.dart';
import 'presenter/cubit/failed_authentication_key_cubit/failed_authentication_key_cubit.dart';
import 'presenter/screens/applicarion_key_screen.dart';
import 'presenter/screens/failed_authentication_key_screen.dart';
import 'presenter/widgets/help_content_widget.dart';

class ApplicationKeyModule extends Module {
  /// Path to redirect after key registration
  String homePath;

  ApplicationKeyModule({required this.homePath});

  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        ApplicationKeyBinds(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          ApplicationKeyRoutes.failedAuthenticationKey,
          child: (context, args) => FailedAuthenticationKeyScreen(
            failedAuthenticationKeyCubit:
                Modular.get<FailedAuthenticationKeyCubit>(),
          ),
        ),
        ChildRoute(
          ApplicationKeyRoutes.registerKey,
          child: (context, args) => ApplicationKeyScreen(
            content: KeyAuthenticationScreen(
              loginWithKeyHelperContent: HelpContentWidget(
                applicationKeyHelpTitle:
                    CollectorLocalizations.of(context).applicationKeyHelpTitle,
                applicationKeyHelpContent1: CollectorLocalizations.of(context)
                    .applicationKeyHelpContent1,
                applicationKeyHelpContent2: CollectorLocalizations.of(context)
                    .applicationKeyHelpContent2,
                applicationKeyHelpContent3: CollectorLocalizations.of(context)
                    .applicationKeyHelpContent3,
                helpTextDocumentationPortal: CollectorLocalizations.of(context)
                    .helpTextDocumentationPortal,
              ),
            ),
            authenticationBloc: Modular.get<AuthenticationBloc>(),
            applicationKeyCubit: Modular.get<ApplicationKeyCubit>(),
            navigatorService: Modular.get<NavigatorService>(),
            homePath: homePath,
          ),
        ),
      ];
}
