import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../blocs/contract_employee_bloc/contract_employee_state.dart';
import '../bloc/profile_menu_screen_bloc.dart';
import 'profile_tab_content_contractual_widget.dart';
import 'profile_tab_content_personal_widget.dart';

class ProfileMenuWidget extends StatefulWidget {
  const ProfileMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileMenuWidget> createState() {
    return _ProfileMenuWidgetState();
  }
}

class _ProfileMenuWidgetState extends State<ProfileMenuWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final bool _hasVisibleProfileContractual;

  @override
  void initState() {
    super.initState();

    _hasVisibleProfileContractual =
        Modular.get<ProfileMenuScreenBloc>().contractEmployeeBloc.state is LoadedContractEmployeeState;
    _tabController = TabController(
      length: _hasVisibleProfileContractual ? 2 : 1,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SeniorTabBar(
          tabs: [
            context.translate.profilePersonal,
            if (_hasVisibleProfileContractual) context.translate.profileContractual,
          ],
          isScrollable: false,
          initialIndex: 0,
          controller: _tabController,
          onTap: (page) => setState(() {
            _tabController.index = page;
          }),
        ),
        Expanded(
          child: SizedBox(
            child: TabBarView(
              controller: _tabController,
              children: [
                const ProfileTabContentPersonalWidget(),
                if (_hasVisibleProfileContractual) const ProfileTabContentContractualWidget(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
