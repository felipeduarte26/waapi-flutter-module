import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../core/constants/assets_path.dart';
import '../../../../../core/enums/analytics/waapi_loading_size_enum.dart';
import '../../../../../core/extension/media_query_extension.dart';
import '../../../../../core/extension/translate_extension.dart';
import '../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../core/widgets/empty_state_widget.dart';
import '../../../../../core/widgets/waapi_colorful_header.dart';
import '../../../../../core/widgets/waapi_loading_widget.dart';
import '../../../../../core/widgets/warning_widget.dart';
import '../../../../../routes/profile_routes.dart';
import '../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../domain/entities/email_entity.dart';
import '../../../domain/entities/profile_entity.dart';
import '../../../enums/personal_request_update_status_enum.dart';
import '../../blocs/profile_bloc/profile_bloc.dart';
import '../../blocs/profile_bloc/profile_state.dart';
import '../edit_personal_contacts_screen/bloc/edit_personal_contact_screen_bloc.dart';
import '../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';
import 'personal_contact_card_widget/personal_contact_card_widget.dart';

class PersonalContactScreen extends StatefulWidget {
  const PersonalContactScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalContactScreen> createState() {
    return _PersonalContactScreenState();
  }
}

class _PersonalContactScreenState extends State<PersonalContactScreen> {
  late ProfileEntity profileEntity;
  late AuthorizationEntity authorizationEntity;
  List<EmailEntity> emailsMerged = [];

  @override
  void initState() {
    super.initState();
    profileEntity = Modular.get<EditPersonalContactScreenBloc>().getProfileBloc.state.profileEntity!;

    if (Modular.get<EditPersonalContactScreenBloc>().getAuthorizationBloc.state is LoadedAuthorizationState) {
      authorizationEntity =
          (Modular.get<EditPersonalContactScreenBloc>().getAuthorizationBloc.state as LoadedAuthorizationState)
              .authorizationEntity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = Modular.get<ProfileMenuScreenBloc>().profileBloc;

    return Scaffold(
      body: WaapiColorfulHeader(
        hasTopPadding: false,
        titleLabel: context.translate.contacts,
        body: BlocBuilder<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          builder: (_, state) {
            final profileEmails = state.profileEntity?.emails ?? [];
            final contractEmails = state.profileEntity?.contract?.emails ?? [];
            emailsMerged = [
              ...profileEmails,
              ...contractEmails,
            ];
            if (state is LoadedProfileState) {
              return personalContactIsEmpty(
                state: state,
              )
                  ? Column(
                      children: [
                        if (profileEntity.contactRequestUpdate != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: SeniorSpacing.normal,
                              left: SeniorSpacing.normal,
                              right: SeniorSpacing.normal,
                            ),
                            child: WarningWidget(
                              message: personalRequestUpdateMessage(),
                              icon: FontAwesomeIcons.solidTriangleExclamation,
                              iconColor: SeniorColors.manchesterColorOrange400,
                            ),
                          ),
                        Expanded(
                          child: EmptyStateWidget(
                            title: context.translate.thereAreNoContactsRegisteredYet,
                            imagePath: AssetsPath.generalEmptyState,
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: SeniorSpacing.normal,
                                  left: SeniorSpacing.normal,
                                  right: SeniorSpacing.normal,
                                ),
                                child: SeniorButton(
                                  disabled: profileEntity.contactRequestUpdate != null,
                                  busy: false,
                                  fullWidth: true,
                                  label: context.translate.addContact,
                                  onPressed: () async {
                                    await Modular.to.pushNamed(
                                      ProfileRoutes.editPersonalContactScreenInitialRoute,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                (state.profileEntity?.contacts == null || state.profileEntity!.contacts!.isEmpty)
                                    ? contactEmpty(
                                        text: context.translate.thereAreNoPhoneNumbersRegisteredYet,
                                        titleGroup: context.translate.phones,
                                      )
                                    : Column(
                                        children: [
                                          if (profileEntity.contactRequestUpdate != null)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: SeniorSpacing.normal,
                                              ),
                                              child: WarningWidget(
                                                message: personalRequestUpdateMessage(),
                                                icon: FontAwesomeIcons.solidTriangleExclamation,
                                                iconColor: SeniorColors.manchesterColorOrange400,
                                              ),
                                            ),
                                          _titleGroup(
                                            title: context.translate.phones,
                                          ),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(
                                              bottom: context.bottomSize,
                                            ),
                                            itemCount: state.profileEntity!.contacts!.length,
                                            itemBuilder: (_, index) {
                                              return PersonalContactCardWidget(
                                                entityQuantity: state.profileEntity!.contacts!.length,
                                                entityIndex: index,
                                                phoneContactEntity: state.profileEntity!.contacts![index],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                (emailsMerged.isEmpty)
                                    ? contactEmpty(
                                        text: context.translate.thereAreNoEmailaddressesRegisteredYet,
                                        titleGroup: context.translate.emails,
                                      )
                                    : Column(
                                        children: [
                                          _titleGroup(
                                            title: context.translate.emails,
                                          ),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(
                                              bottom: context.bottomSize,
                                            ),
                                            itemCount: emailsMerged.length,
                                            itemBuilder: (_, index) {
                                              final emailEntity = emailsMerged[index];
                                              return emailEntity.email != null
                                                  ? PersonalContactCardWidget(
                                                      entityQuantity: emailsMerged.length,
                                                      entityIndex: index,
                                                      emailEntity: emailEntity,
                                                    )
                                                  : const SizedBox();
                                            },
                                          ),
                                        ],
                                      ),
                                (state.profileEntity?.socialNetworks == null ||
                                        state.profileEntity!.socialNetworks!.isEmpty)
                                    ? contactEmpty(
                                        text: context.translate.thereAreNoSocialNetworksRegisteredYet,
                                        titleGroup: context.translate.socialNetworks,
                                      )
                                    : Column(
                                        children: [
                                          _titleGroup(
                                            title: context.translate.socialNetworks,
                                          ),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: EdgeInsets.only(
                                              bottom: context.bottomSize,
                                            ),
                                            itemCount: state.profileEntity!.socialNetworks!.length,
                                            itemBuilder: (_, index) {
                                              return PersonalContactCardWidget(
                                                entityQuantity: state.profileEntity!.socialNetworks!.length,
                                                entityIndex: index,
                                                socialNetworkEntity: state.profileEntity!.socialNetworks![index],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                        authorizationEntity.allowToUpdatePersonalContact
                            ? EmployeeBottomSheetWidget(
                                horizontalPadding: true,
                                seniorButtons: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: SeniorSpacing.normal,
                                    ),
                                    child: SeniorButton(
                                      disabled: profileEntity.contactRequestUpdate != null,
                                      busy: false,
                                      fullWidth: true,
                                      label: context.translate.edit,
                                      onPressed: () async {
                                        await Modular.to.pushNamed(
                                          ProfileRoutes.editPersonalContactScreenInitialRoute,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
            }
            return const Center(
              child: WaapiLoadingWidget(
                waapiLoadingSizeEnum: WaapiLoadingSizeEnum.big,
              ),
            );
          },
        ),
      ),
      backgroundColor: SeniorColors.neutralColor100,
    );
  }

  Widget _titleGroup({
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SeniorSpacing.normal,
        left: SeniorSpacing.normal,
        right: SeniorSpacing.normal,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: SeniorText.label(
          title,
          color: SeniorColors.secondaryColor900,
        ),
      ),
    );
  }

  bool personalContactIsEmpty({required ProfileState state}) {
    return (state.profileEntity?.contacts == null || state.profileEntity!.contacts!.isEmpty) &&
        (state.profileEntity?.emails == null || state.profileEntity!.emails!.isEmpty) &&
        (state.profileEntity?.socialNetworks == null || state.profileEntity!.socialNetworks!.isEmpty);
  }

  Widget contactEmpty({required String text, required String titleGroup}) {
    final isCustomTheme = Provider.of<ThemeRepository>(context).isCustomTheme();
    return Column(
      children: [
        _titleGroup(
          title: titleGroup,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          child: SeniorCard(
            padding: const EdgeInsets.symmetric(
              vertical: SeniorSpacing.small,
              horizontal: SeniorSpacing.medium,
            ),
            withElevation: isCustomTheme,
            style: isCustomTheme
                ? const SeniorCardStyle(
                    outlinedColor: SeniorColors.grayscale50,
                    backgroundColor: SeniorColors.pureWhite,
                  )
                : null,
            child: Row(
              children: [
                const SeniorIcon(
                  icon: FontAwesomeIcons.solidTriangleExclamation,
                  size: SeniorSpacing.big,
                ),
                const SizedBox(
                  width: SeniorSpacing.medium,
                ),
                Expanded(
                  child: SeniorText.body(
                    text,
                    color: SeniorColors.pureBlack,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String personalRequestUpdateMessage() {
    if (profileEntity.personalRequestUpdate?.status == PersonalRequestUpdateStatusEnum.awaitingReview) {
      return context.translate.theInformationPresentedIsUnderAnalysis;
    }
    return context.translate.theInformationPresentedIsUnderProcessing;
  }
}
