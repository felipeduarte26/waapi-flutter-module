import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/clipboard_helper.dart';

import '../../../../../../core/widgets/document_item_widget.dart';
import '../../../../../../core/widgets/waapi_card_widget.dart';
import '../../../../../../routes/profile_routes.dart';
import '../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_bloc.dart';
import '../../../../../active_contract/presenter/blocs/active_contract_bloc/active_contract_state.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/emergencial_contact_entity.dart';
import '../../../../helper/phone_contact_helper.dart';
import '../../../blocs/person_bloc/person_bloc.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_bloc.dart';
import '../../../blocs/profile_bloc/profile_event.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../../../string_formatters/enum_gender_string_formatter.dart';
import '../../../string_formatters/enum_personal_relationship_string_formatter.dart';
import '../../profile_menu_screen/bloc/profile_menu_screen_bloc.dart';

class EmergencialContactsCardWidget extends StatefulWidget {
  final EmergencialContactEntity emergencialContactEntity;
  final int index;
  final bool isPublicProfile;

  const EmergencialContactsCardWidget({
    Key? key,
    required this.emergencialContactEntity,
    required this.index,
    this.isPublicProfile = false,
  }) : super(key: key);

  @override
  State<EmergencialContactsCardWidget> createState() => _EmergencialContactsCardWidgetState();
}

class _EmergencialContactsCardWidgetState extends State<EmergencialContactsCardWidget> {
  final PersonBloc _personBloc = Modular.get<PersonBloc>();
  final ActiveContractBloc _activeContractBloc = Modular.get<ActiveContractBloc>();
  final ProfileBloc _profileBloc = Modular.get<ProfileBloc>();
  late AuthorizationEntity authorizationEntity;

  @override
  void initState() {
    super.initState();
    final authorizationState = Modular.get<ProfileMenuScreenBloc>().state.authorizationState;
    authorizationEntity = (authorizationState as LoadedAuthorizationState).authorizationEntity;
  }

  @override
  Widget build(BuildContext context) {
    final number = PhoneContactHelper.getFullPhone(
      phoneContact: widget.emergencialContactEntity.phoneContact,
    );
    return Padding(
      padding: EdgeInsets.only(
        top: widget.index == 0 ? SeniorSpacing.normal : 0,
        left: widget.isPublicProfile ? 0 : SeniorSpacing.normal,
        right: widget.isPublicProfile ? 0 : SeniorSpacing.normal,
        bottom: SeniorSpacing.normal,
      ),
      child: WaapiCardWidget(
        padding: const EdgeInsets.only(
          left: SeniorSpacing.normal,
        ),
        showActionIcon: false,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.xsmall,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SeniorIcon(
                    icon: FontAwesomeIcons.solidUser,
                    size: SeniorSpacing.medium,
                  ),
                  const SizedBox(
                    width: SeniorSpacing.small,
                  ),
                  Expanded(
                    child: SeniorText.body(
                      darkColor: Provider.of<ThemeRepository>(context).theme.textTheme!.bodyStyle!.color!,
                      widget.emergencialContactEntity.name!,
                      color: SeniorColors.neutralColor800,
                      textProperties: const TextProperties(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SeniorIconButton(
                    disabled: (number == null || number == ''),
                    icon: FontAwesomeIcons.solidCopy,
                    onTap: () async {
                      if (number != null && number.isNotEmpty) {
                        ClipboardHelper.copy(
                          value: number,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SeniorSnackBar.message(
                            message: context.translate.phoneNumberCopiedSuccessfully,
                          ),
                        );
                      }
                    },
                    size: SeniorIconButtonSize.big,
                    type: SeniorIconButtonType.ghost,
                    outlined: false,
                    style: SeniorIconButtonStyle(
                      borderColor: Colors.transparent,
                      iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                          ? SeniorColors.pureWhite
                          : SeniorColors.secondaryColor600,
                      disabledBorderColor: Colors.transparent,
                      disabledIconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                          ? SeniorColors.grayscale60
                          : SeniorColors.neutralColor300,
                      buttonColor: Colors.transparent,
                      disabledButtonColor: Colors.transparent,
                    ),
                  ),
                  authorizationEntity.allowToUpdateEmergencyContact && !widget.isPublicProfile
                      ? SeniorIconButton(
                          icon: FontAwesomeIcons.solidPen,
                          onTap: () async {
                            final isRequested = await Modular.to.pushNamed<bool>(
                              ProfileRoutes.emergencialContactsDetailsInitialRoute,
                              arguments: {
                                'emergencialContactEntity': widget.emergencialContactEntity,
                              },
                            );

                            if (isRequested != null && isRequested) {
                              setState(() {
                                final String personId = (_personBloc.state as LoadedPersonState).personId;
                                final String employeeId = (_activeContractBloc.state as LoadedActiveContractState)
                                    .activeContractEntity
                                    .employeeId;

                                if (_profileBloc.state is LoadedProfileState) {
                                  Modular.get<ProfileBloc>().add(
                                    GetProfileEvent(
                                      personId: personId,
                                      employeeId: employeeId,
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          size: SeniorIconButtonSize.big,
                          type: SeniorIconButtonType.ghost,
                          outlined: false,
                          style: SeniorIconButtonStyle(
                            borderColor: Colors.transparent,
                            iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                                ? SeniorColors.pureWhite
                                : SeniorColors.secondaryColor600,
                            disabledBorderColor: Colors.transparent,
                            disabledIconColor: SeniorColors.neutralColor300,
                            buttonColor: Colors.transparent,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              (number != null && number.isNotEmpty)
                  ? DocumentItemWidget(
                      padding: const EdgeInsets.only(
                        left: SeniorSpacing.big,
                        bottom: SeniorSpacing.xsmall,
                      ),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      title: context.translate.phoneNumber,
                      items: [
                        number,
                      ],
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(
                  right: SeniorSpacing.normal,
                ),
                child: Row(
                  children: [
                    widget.emergencialContactEntity.relationship != null
                        ? Expanded(
                            child: DocumentItemWidget(
                              padding: const EdgeInsets.only(
                                left: SeniorSpacing.big,
                                bottom: SeniorSpacing.xsmall,
                              ),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              title: context.translate.relationshipDegree,
                              items: [
                                EnumPersonalRelationshipStringFormatter.personalRelationshipEnumToValue(
                                  personalRelationshipEnum: widget.emergencialContactEntity.relationship!,
                                  appLocalizations: context.translate,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    widget.emergencialContactEntity.genderType != null
                        ? DocumentItemWidget(
                            padding: const EdgeInsets.only(
                              left: SeniorSpacing.big,
                              bottom: SeniorSpacing.xsmall,
                            ),
                            crossAxisAlignment: widget.emergencialContactEntity.relationship != null
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            title: context.translate.gender,
                            items: [
                              EnumGenderStringFormatter.getEnumGenderTypeString(
                                genderTypeEnum: widget.emergencialContactEntity.genderType!,
                                appLocalizations: context.translate,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: SeniorSpacing.normal,
                ),
                child: Row(
                  children: [
                    widget.emergencialContactEntity.phoneContact?.branch != null
                        ? Expanded(
                            child: DocumentItemWidget(
                              padding: const EdgeInsets.only(
                                left: SeniorSpacing.big,
                                bottom: SeniorSpacing.xsmall,
                              ),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              title: context.translate.extension,
                              items: [
                                widget.emergencialContactEntity.phoneContact!.branch!,
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    widget.emergencialContactEntity.phoneContact?.provider != null
                        ? DocumentItemWidget(
                            padding: const EdgeInsets.only(
                              left: SeniorSpacing.big,
                              bottom: SeniorSpacing.xsmall,
                            ),
                            crossAxisAlignment: widget.emergencialContactEntity.phoneContact?.branch != null
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            title: context.translate.operator,
                            items: [
                              widget.emergencialContactEntity.phoneContact!.provider!,
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
