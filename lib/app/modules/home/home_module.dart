import 'package:flutter_modular/flutter_modular.dart';

import '../../core/services/has_clocking/has_clocking_instance.dart';
import '../../core/services/integration_user/integration_user_instance.dart';
import '../../routes/routes.dart';
import '../active_contract/active_contract_module.dart';
import '../attachment/attachment_module.dart';
import '../authentication/authentication_module.dart';
import '../authorization/authorization_module.dart';
import '../corporate_mural/corporate_mural_module.dart';
import '../feedback/feedback_module.dart';
import '../financial_data/financial_data_module.dart';
import '../happiness_index/happiness_index_module.dart';
import '../hyperlink/hyperlink_module.dart';
import '../management_panel/management_panel_module.dart';
import '../moods/moods_module.dart';
import '../personalization/personalization_module.dart';
import '../profile/profile_module.dart';
import '../search_person/search_person_module.dart';
import '../social/binds/social_domain_binds.dart';
import '../social/binds/social_external_binds.dart';
import '../social/binds/social_infra_binds.dart';
import '../social/binds/social_presenter_binds.dart';
import '../vacations/vacations_module.dart';
import 'home_presenter_binds.dart';
import 'presenter/home_screen.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...HomePresenterBinds.binds,
      ...SocialDomainBinds.binds,
      ...SocialExternalBinds.binds,
      ...SocialInfraBinds.binds,
      ...SocialPresenterBinds.binds,
    ];
  }

  @override
  List<Module> get imports {
    return [
      ManagementPanelModule(),
      HasClockingInstance(),
      AuthorizationModule(),
      ActiveContractModule(),
      FeedbackModule(),
      ProfileModule(),
      CorporateMuralModule(),
      HappinessIndexModule(),
      VacationsModule(),
      SearchPersonModule(),
      AuthenticationModule(),
      AttachmentModule(),
      FinancialDataModule(),
      PersonalizationModule(),
      HyperlinkModule(),
      MoodsModule(),
      IntegrationUserInstance(),
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        HomeRoutes.homeScreenRoute,
        transition: TransitionType.noTransition,
        child: (_, args) {
          return HomeScreen(
            dataClockingFutureToBuild: args.data['dataClockingFuture'],
          );
        },
      ),
    ];
  }
}
