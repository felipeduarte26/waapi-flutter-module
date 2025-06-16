import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../domain/entities/contact_entity.dart';
import '../../../../domain/entities/social_network_entity.dart';
import '../../../../enums/social_network_provider_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../string_formatters/enum_social_network_provider_string_formatter.dart';

class InputSocialNetworkBottomSheetContentWidget extends StatefulWidget {
  final ValueChanged<ContactEntity<SocialNetworkEntity>> primaryButtonPressed;
  final VoidCallback secondaryButtonPressed;
  final String typeEdit;
  final ContactEntity<SocialNetworkEntity>? contactEntity;

  const InputSocialNetworkBottomSheetContentWidget({
    Key? key,
    required this.primaryButtonPressed,
    required this.secondaryButtonPressed,
    required this.typeEdit,
    this.contactEntity,
  }) : super(key: key);

  @override
  State<InputSocialNetworkBottomSheetContentWidget> createState() {
    return _InputSocialNetworkBottomSheetContentWidgetState();
  }
}

class _InputSocialNetworkBottomSheetContentWidgetState extends State<InputSocialNetworkBottomSheetContentWidget> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contactEntity != null) {
      userController.text = widget.contactEntity!.content.profile ?? '';
      if (widget.contactEntity!.content.socialNetwork != null) {
        typeController.text = EnumHelper<SocialNetworkProviderEnum>().enumToString(
          enumToParse: widget.contactEntity!.content.socialNetwork!,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeRepository>(context).isDarkTheme();
    return Scaffold(
      backgroundColor: isDarkMode
          ? Provider.of<ThemeRepository>(context).theme.colorfulHeaderStructureTheme!.style!.bodyColor
          : SeniorColors.pureWhite,
      body: Padding(
        padding: const EdgeInsets.only(
          top: SeniorSpacing.normal,
        ),
        child: Scrollbar(
          child: CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: [
              SliverToBoxAdapter(
                child: SeniorText.body(
                  '* ${context.translate.mandatoryItem}',
                  color: SeniorColors.neutralColor600,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.xmedium,
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorDropdownButton(
                  value: EnumHelper<SocialNetworkProviderEnum>().stringToEnum(
                    stringToParse: typeController.text,
                    values: SocialNetworkProviderEnum.values,
                  ),
                  disabled: false,
                  items: DropdownItemListEnum<SocialNetworkProviderEnum>().dropdownItemList(
                    values: SocialNetworkProviderEnum.values,
                    title: (socialNetworkProviderEnum) =>
                        EnumSocialNetworkProviderStringFormatter.getStringSocialNetwork(
                      socialNetworkProviderEnum: socialNetworkProviderEnum,
                      appLocalizations: context.translate,
                    ),
                  ),
                  onSelected: (socialNetworkProviderEnum) {
                    typeController.text = EnumHelper<SocialNetworkProviderEnum>().enumToString(
                      enumToParse: socialNetworkProviderEnum,
                    );
                    setState(() {});
                  },
                  label: context.translate.socialNetwork,
                  style: SeniorDropdownButtonStyle(
                    itemListTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: SeniorSpacing.normal,
                ),
              ),
              SliverToBoxAdapter(
                child: SeniorTextField(
                  disabled: false,
                  controller: userController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  label: '${context.translate.userOrAddress} *',
                  style: SeniorTextFieldStyle(
                    hintTextColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                    textColor: isDarkMode ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EmployeeBottomSheetWidget(
        horizontalPadding: false,
        seniorButtons: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorButton(
              disabled: userController.text.isEmpty || typeController.text.isEmpty,
              busy: false,
              fullWidth: true,
              label: context.translate.save,
              onPressed: () {
                widget.primaryButtonPressed(
                  ContactEntity(
                    typeEdit: widget.typeEdit,
                    content: SocialNetworkEntity(
                      id: widget.contactEntity?.content.id,
                      profile: userController.text,
                      socialNetwork: EnumHelper<SocialNetworkProviderEnum>().stringToEnum(
                        stringToParse: typeController.text,
                        values: SocialNetworkProviderEnum.values,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
            ),
            child: SeniorButton.ghost(
              disabled: false,
              fullWidth: true,
              label: context.translate.close,
              onPressed: () {
                widget.secondaryButtonPressed();
              },
            ),
          ),
        ],
      ),
    );
  }
}
