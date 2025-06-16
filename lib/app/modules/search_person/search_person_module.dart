import 'package:flutter_modular/flutter_modular.dart';

import '../../routes/routes.dart';
import 'binds/search_person_domain_binds.dart';
import 'binds/search_person_external_binds.dart';
import 'binds/search_person_infra_binds.dart';
import 'binds/search_person_presenter_binds.dart';
import 'presenter/screens/search_person_screen/blocs/search_person_screen_bloc.dart';
import 'presenter/screens/search_person_screen/search_person_screen.dart';

class SearchPersonModule extends Module {
  @override
  List<Bind<Object>> get binds {
    return [
      ...SearchPersonDomainBinds.binds,
      ...SearchPersonInfraBinds.binds,
      ...SearchPersonExternalBinds.binds,
      ...SearchPersonPresenterBinds.binds,
    ];
  }

  @override
  List<ModularRoute> get routes {
    return [
      ChildRoute(
        SearchPersonRoutes.searchPersonScreenRoute,
        child: (_, args) {
          return SearchPersonScreen(
            searchPersonScreenBloc: Modular.get<SearchPersonScreenBloc>(),
          );
        },
      ),
    ];
  }
}
