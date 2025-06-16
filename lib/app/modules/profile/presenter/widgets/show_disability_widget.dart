import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/extension/translate_extension.dart';
import '../../../../core/widgets/waapi_card_widget.dart';
import '../../domain/entities/disability_entity.dart';
import '../blocs/disability_bloc/disability_event.dart';
import '../blocs/disability_bloc/disability_state.dart';
import '../screens/edit_personal_data/bloc/edit_personal_data_screen_bloc.dart';

class ShowDisabilityWidget extends StatefulWidget {
  final DisabilityEntity disability;
  final List<SeniorDropdownButtonItem> disabilitiesItems;

  const ShowDisabilityWidget({
    super.key,
    required this.disability,
    required this.disabilitiesItems,
  });

  @override
  State<ShowDisabilityWidget> createState() {
    return _ShowDisabilityWidgetState();
  }
}

class _ShowDisabilityWidgetState extends State<ShowDisabilityWidget> {
  late final EditPersonalDataScreenBloc _editPersonalDataScreenBloc;

  @override
  void initState() {
    super.initState();
    _editPersonalDataScreenBloc = Modular.get<EditPersonalDataScreenBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return WaapiCardWidget(
      height: SeniorSpacing.huge,
      showActionIcon: false,
      child: Row(
        children: [
          SeniorText.body(
            widget.disability.name!,
            color: SeniorColors.neutralColor800,
          ),
          const Expanded(
            child: SizedBox.shrink(),
          ),
          SeniorIconButton(
            disabled: widget.disabilitiesItems.isEmpty,
            icon: FontAwesomeIcons.solidPen,
            size: SeniorIconButtonSize.small,
            style: SeniorIconButtonStyle(
              iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                  ? SeniorColors.pureWhite
                  : SeniorColors.secondaryColor600,
              borderColor: Colors.transparent,
              disabledBorderColor: Colors.transparent,
              buttonColor: Colors.transparent,
            ),
            onTap: () => _editDisability(context),
            type: SeniorIconButtonType.ghost,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: SeniorSpacing.normal,
            ),
            child: SeniorIconButton(
              icon: FontAwesomeIcons.solidTrash,
              size: SeniorIconButtonSize.small,
              style: SeniorIconButtonStyle(
                iconColor: Provider.of<ThemeRepository>(context).isDarkTheme()
                    ? SeniorColors.pureWhite
                    : SeniorColors.secondaryColor600,
                borderColor: Colors.transparent,
                buttonColor: Colors.transparent,
              ),
              onTap: () => _deleteDisability(context),
              type: SeniorIconButtonType.ghost,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteDisability(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return SeniorModal(
          title: context.translate.removeDisability,
          content: context.translate.removeRegister,
          defaultAction: SeniorModalAction(
            label: context.translate.close,
            action: () => Modular.to.pop(),
          ),
          otherAction: SeniorModalAction(
            label: context.translate.delete,
            action: () {
              _editPersonalDataScreenBloc.getDisabilityBloc.add(
                UnselectDisabilityFromEntityToProfileEvent(
                  disabilityEntity: widget.disability,
                ),
              );
              Modular.to.pop();
            },
            danger: true,
          ),
        );
      },
    );
  }

  void _editDisability(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context, listen: false);
    String disabilitySelected = '';
    SeniorBottomSheet.showBottomSheet(
      title: context.translate.defineDisability,
      context: context,
      height: context.bottomSheetSize,
      content: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SeniorSpacing.normal,
          ),
          child: SeniorDropdownButton(
            value: widget.disability.id,
            items: widget.disabilitiesItems,
            onSelected: (selected) {
              disabilitySelected = selected;
            },
            label: context.translate.disability,
            style: SeniorDropdownButtonStyle(
              itemListTextColor: themeRepository.isDarkTheme() ? SeniorColors.pureWhite : SeniorColors.neutralColor900,
            ),
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
        Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          child: SeniorButton(
            disabled: (_editPersonalDataScreenBloc.getDisabilityBloc.state is LoadingDisabilityState),
            fullWidth: true,
            label: context.translate.save,
            onPressed: () {
              _editPersonalDataScreenBloc.getDisabilityBloc.add(
                UnselectDisabilityFromEntityToProfileEvent(
                  disabilityEntity: widget.disability,
                ),
              );

              final id = widget.disabilitiesItems.where((e) => e.value == disabilitySelected).first.value;
              final name = widget.disabilitiesItems.where((e) => e.value == disabilitySelected).first.title;

              _editPersonalDataScreenBloc.getDisabilityBloc.add(
                SelectDisabilityFromEntityToProfileEvent(
                  disabilityEntity: DisabilityEntity(
                    id: id,
                    name: name,
                  ),
                ),
              );

              Modular.to.pop();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: SeniorSpacing.normal,
            left: SeniorSpacing.normal,
            right: SeniorSpacing.normal,
          ),
          child: SeniorButton.ghost(
            disabled: false,
            fullWidth: true,
            label: context.translate.optionCancel,
            onPressed: () {
              Modular.to.pop();
            },
          ),
        ),
      ],
      hasCloseButton: true,
      onTapCloseButton: () {
        Modular.to.pop();
      },
    );
  }
}
