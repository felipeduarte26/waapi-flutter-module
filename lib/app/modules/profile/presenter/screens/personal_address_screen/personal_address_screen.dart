import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/warning_widget.dart';
import '../../../../../routes/profile_routes.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../enums/personal_request_update_status_enum.dart';
import '../../blocs/profile_bloc/profile_bloc.dart';
import '../../blocs/profile_bloc/profile_state.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';
import 'widgets/waapi_personal_address_card_widget.dart';

class PersonalAddressScreen extends StatefulWidget {
  const PersonalAddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalAddressScreen> createState() {
    return _PersonalAddressScreenState();
  }
}

class _PersonalAddressScreenState extends State<PersonalAddressScreen> {
  late ProfileMenuScreenBloc _profileMenuScreenBloc;
  late ProfileEntity profileEntity;
  late AuthorizationEntity authorizationEntity;

  @override
  void initState() {
    super.initState();
    _profileMenuScreenBloc = Modular.get<ProfileMenuScreenBloc>();
    profileEntity = _profileMenuScreenBloc.profileBloc.state.profileEntity!;
    AuthorizationState authorizationState = _profileMenuScreenBloc.authorizationBloc.state;

    if (authorizationState is LoadedAuthorizationState) {
      authorizationEntity = authorizationState.authorizationEntity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WaapiColorfulHeader(
        titleLabel: context.translate.personalAddress,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: _profileMenuScreenBloc.profileBloc,
          builder: (_, state) {
            final addressEntity = state.profileEntity?.currentAddress;

            return Scrollbar(
              child: isEmpty()
                  ? Column(
                      children: [
                        if (profileEntity.addressRequestUpdate != null)
                          Padding(
                            padding: const EdgeInsets.only(top: SeniorSpacing.normal,),
                            child: WarningWidget(
                              message: addressRequestUpdateMessage(),
                              icon: FontAwesomeIcons.solidTriangleExclamation,
                              iconColor: SeniorColors.manchesterColorOrange400,
                            ),
                          ),
                        Expanded(
                          child: EmptyStateWidget(
                            title: context.translate.noPersonalAddressRegisteredYet,
                            imagePath: AssetsPath.generalEmptyState,
                          ),
                        ),
                        if (authorizationEntity.allowToUpdatePersonalAddress)
                          EmployeeBottomSheetWidget(
                            horizontalPadding: true,
                            seniorButtons: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: SeniorSpacing.normal,
                                ),
                                child: SeniorButton(
                                  disabled: profileEntity.addressRequestUpdate?.status != null,
                                  busy: false,
                                  fullWidth: true,
                                  label: context.translate.addPersonalAddress,
                                  onPressed: () async {
                                    await Modular.to.pushNamed(
                                      ProfileRoutes.editPersonalAddressScreenRouteInitialRoute,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  : Column(
                      key: const Key('profile-personal_address_screen'),
                      children: [
                        if (profileEntity.addressRequestUpdate != null)
                          Padding(
                            padding: const EdgeInsets.only(top: SeniorSpacing.normal,),
                            child: WarningWidget(
                              message: addressRequestUpdateMessage(),
                              icon: FontAwesomeIcons.solidTriangleExclamation,
                              iconColor: SeniorColors.manchesterColorOrange400,
                            ),
                          ),
                        if (addressEntity != null)
                          WaapiPersonalAddressCardWidget(
                            addressEntity: addressEntity,
                          ),
                        const Expanded(
                          child: SizedBox.shrink(),
                        ),
                        if (authorizationEntity.allowToUpdatePersonalAddress)
                          EmployeeBottomSheetWidget(
                            horizontalPadding: true,
                            seniorButtons: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: SeniorSpacing.normal,
                                ),
                                child: SeniorButton(
                                  disabled: profileEntity.addressRequestUpdate?.status != null,
                                  busy: false,
                                  fullWidth: true,
                                  label: context.translate.edit,
                                  onPressed: () async {
                                    await Modular.to.pushNamed(
                                      ProfileRoutes.editPersonalAddressScreenRouteInitialRoute,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  String addressRequestUpdateMessage() {
    if (profileEntity.addressRequestUpdate?.status == PersonalRequestUpdateStatusEnum.awaitingReview) {
      return context.translate.theInformationPresentedIsUnderAnalysis;
    }
    return context.translate.theInformationPresentedIsUnderProcessing;
  }

  bool isEmpty() {
    return (profileEntity.currentAddress?.address == null) && (profileEntity.currentAddress?.postalCode == null);
  }
}
