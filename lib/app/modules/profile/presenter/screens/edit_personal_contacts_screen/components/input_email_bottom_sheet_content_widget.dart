import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/enum_helper.dart';
import '../../../../../../core/widgets/employee_bottom_sheet_widget.dart';
import '../../../../../authorization/domain/entities/authorization_entity.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../../domain/entities/contact_entity.dart';
import '../../../../domain/entities/email_entity.dart';
import '../../../../enums/email_type_enum.dart';
import '../../../../helper/dropdown_item_list_enum.dart';
import '../../../string_formatters/enum_email_type_string_formatter.dart';
import '../bloc/edit_personal_contact_screen_bloc.dart';

class InputEmailBottomSheetContentWidget extends StatefulWidget {
  final ValueChanged<ContactEntity<EmailEntity>> primaryButtonPressed;
  final VoidCallback secondaryButtonPressed;
  final String typeEdit;
  final ContactEntity<EmailEntity>? contactEntity;

  const InputEmailBottomSheetContentWidget({
    Key? key,
    required this.primaryButtonPressed,
    required this.secondaryButtonPressed,
    required this.typeEdit,
    this.contactEntity,
  }) : super(key: key);

  @override
  State<InputEmailBottomSheetContentWidget> createState() {
    return _InputEmailBottomSheetContentWidgetState();
  }
}

class _InputEmailBottomSheetContentWidgetState extends State<InputEmailBottomSheetContentWidget> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  late final EditPersonalContactScreenBloc _editPersonalContactScreenBloc;
  late final AuthorizationEntity authorizationEntity;

  @override
  void initState() {
    super.initState();
    _editPersonalContactScreenBloc = Modular.get<EditPersonalContactScreenBloc>();

    authorizationEntity =
        (_editPersonalContactScreenBloc.getAuthorizationBloc.state as LoadedAuthorizationState).authorizationEntity;

    if (widget.contactEntity != null) {
      userController.text = widget.contactEntity!.content.email ?? '';
      if (widget.contactEntity!.content.email != null) {
        typeController.text = EnumHelper<EmailTypeEnum>()
            .enumToString(
              enumToParse: widget.contactEntity!.content.type ?? EmailTypeEnum.professional,
            )
            .toUpperCase();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<SeniorDropdownButtonItem> dropdownItemList = [];

    if (!authorizationEntity.allowToUpdateContactProfessionalEmail) {
      dropdownItemList.add(
        SeniorDropdownButtonItem(
          value: !authorizationEntity.allowToUpdateContactProfessionalEmail
              ? EmailTypeEnum.personal
              : EmailTypeEnum.values,
          title: EnumEmailTypeStringFormatter.getEmailTypeString(
            appLocalizations: context.translate,
            emailTypeEnum: EmailTypeEnum.personal,
          ),
        ),
      );
    } else {
      dropdownItemList = DropdownItemListEnum<EmailTypeEnum>().dropdownItemList(
        values: EmailTypeEnum.values,
        title: (emailTypeEnum) => EnumEmailTypeStringFormatter.getEmailTypeString(
          appLocalizations: context.translate,
          emailTypeEnum: emailTypeEnum,
        ),
      );
    }

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
                  value: EnumHelper<EmailTypeEnum>().stringToEnum(
                    stringToParse: typeController.text,
                    values: EmailTypeEnum.values,
                  ),
                  disabled: false,
                  items: dropdownItemList,
                  onSelected: (mailTypeEnum) {
                    setState(() {
                      typeController.text = EnumHelper<EmailTypeEnum>().enumToString(
                        enumToParse: mailTypeEnum,
                      );
                    });
                  },
                  label: context.translate.email,
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
                  validator: (value) {
                    if (value != null) {
                      final atSign = value.contains('@');

                      if (atSign) {
                        if (value.substring(value.length - 1, value.length) == '@') {
                          return context.translate.wrongAlert;
                        }
                      } else {
                        return context.translate.wrongAlert;
                      }
                    }
                    return null;
                  },
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
                    content: EmailEntity(
                      id: widget.contactEntity?.content.id,
                      employeeId: widget.contactEntity?.content.employeeId,
                      email: userController.text,
                      type: EnumHelper<EmailTypeEnum>().stringToEnum(
                        stringToParse: typeController.text,
                        values: EmailTypeEnum.values,
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
