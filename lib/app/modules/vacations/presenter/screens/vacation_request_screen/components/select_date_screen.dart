import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/tokens/senior_colors.dart';
import 'package:senior_design_tokens/tokens/senior_spacing.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/date_time_helper.dart';
import '../../../../../../core/helper/locale_helper.dart';
import '../../../../../../core/theme/waapi_style_theme.dart';
import '../../../../../../core/widgets/warning_widget.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_bloc.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../bloc/vacation_request_screen_bloc.dart';

class SelectDateScreen extends StatefulWidget {
  final TextEditingController qntDaysController;
  final TextEditingController dateController;
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final bool christmasBonus;
  final bool vacationBonus;
  final ValueChanged<bool?> onChangedChristmasBonus;
  final ValueChanged<bool?> onChangedVacationBonus;
  final TextEditingController qntDaysVacationBonusController;
  final TextEditingController notesController;
  final double vacationBalance;

  const SelectDateScreen({
    Key? key,
    required this.qntDaysController,
    required this.dateController,
    required this.selectedDate,
    required this.onDateChanged,
    required this.christmasBonus,
    required this.vacationBonus,
    required this.onChangedChristmasBonus,
    required this.onChangedVacationBonus,
    required this.qntDaysVacationBonusController,
    required this.notesController,
    required this.vacationBalance,
  }) : super(key: key);

  @override
  State<SelectDateScreen> createState() {
    return _SelectDateScreenState();
  }
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  late final VacationRequestScreenBloc _vacationRequestScreenBloc;
  bool canChristmasBonus = false;
  bool canVacationBonus = false;

  @override
  void initState() {
    super.initState();
    _vacationRequestScreenBloc = Modular.get<VacationRequestScreenBloc>();

    final authorizationBloc = _vacationRequestScreenBloc.authorizationBloc;
    final state = authorizationBloc.state;
    if (state is LoadedAuthorizationState) {
      final authorizationEntity = state.authorizationEntity;
      canChristmasBonus = authorizationEntity.show13thSalaryAdvance;
      canVacationBonus = authorizationEntity.showBonusDays;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SeniorSpacing.normal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.h4(
                context.translate.vacationDays,
              ),
            ),
            BlocBuilder<AuthorizationBloc, AuthorizationState>(
              bloc: _vacationRequestScreenBloc.authorizationBloc,
              builder: (context, state) {
                final String? vacationPolicy =
                    state is LoadedAuthorizationState ? state.authorizationEntity.vacationHelpDescription : null;

                if (vacationPolicy == null || vacationPolicy.isEmpty) {
                  return const SizedBox.shrink();
                }

                return WarningWidget(
                  message: vacationPolicy,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.body(
                '* ${context.translate.mandatoryItem}',
                color: SeniorColors.neutralColor600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorText.label(
                context.translate.vacationPeriodBegin,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
              bottom: SeniorSpacing.normal,
              ),
              child: SeniorTextField(
              textInputAction: TextInputAction.done,
              controller: widget.qntDaysController,
              maxLength: 2,
              label: (int.tryParse(widget.qntDaysVacationBonusController.text) ?? 0) <= 0
                ? '${context.translate.vacationPeriod} *'
                : context.translate.vacationPeriod,
              helper: context.translate.vacationDaysHelper,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: const SeniorTextFieldStyle(
                hintTextColor: SeniorColors.neutralColor900,
              ),
              onChanged: (value) {
                final intValue = int.tryParse(value) ?? 0;
                final maxDays = widget.vacationBalance.floor();

                if (intValue > maxDays) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SeniorSnackBar.warning(
                  message: context.translate.maxVacationDays(maxDays),
                  ),
                );
                }
              },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: GestureDetector(
                onTap: _pickDate,
                child: SeniorTextField(
                  controller: widget.dateController,
                  label: '${context.translate.startDateVacation} *',
                  readOnly: true,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  suffixIcon: FontAwesomeIcons.solidCalendar,
                  helper: context.translate.startDateVacationHelper,
                  style: const SeniorTextFieldStyle(
                    hintTextColor: SeniorColors.neutralColor900,
                  ),
                  onTap: _pickDate,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: SeniorSpacing.normal,
              ),
              child: SeniorButton(
                label: context.translate.viewCalendar,
                onPressed: _pickDate,
                fullWidth: true,
                outlined: true,
                style: WaapiStyleTheme.waapiSeniorButtonGhostOutlinedStyle(context),
              ),
            ),

            canChristmasBonus
                ? Padding(
                    padding: const EdgeInsets.only(bottom: SeniorSpacing.normal),
                    child: SeniorCheckbox(
                      actionOnTitle: true,
                      value: widget.christmasBonus,
                      title: context.translate.christmasBonus,
                      onChanged: widget.onChangedChristmasBonus,
                    ),
                  )
                : const SizedBox.shrink(),
            canVacationBonus
                ? Padding(
                    padding: const EdgeInsets.only(bottom: SeniorSpacing.normal),
                    child: SeniorCheckbox(
                      actionOnTitle: true,
                      value: widget.vacationBonus,
                      title: context.translate.vacationBonus,
                      onChanged: widget.onChangedVacationBonus,
                    ),
                  )
                : const SizedBox.shrink(),
            canVacationBonus
                ? Padding(
                    padding: const EdgeInsets.only(bottom: SeniorSpacing.normal),
                    child: SeniorTextField(
                      disabled: !widget.vacationBonus,
                      controller: widget.qntDaysVacationBonusController,
                      maxLength: 2,
                      label: '${context.translate.allowance} *',
                      helper: context.translate.vacationBonusHelper,
                      keyboardType: const TextInputType.numberWithOptions(signed: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: const SeniorTextFieldStyle(
                        hintTextColor: SeniorColors.neutralColor900,
                      ),
                      onChanged: (value) {
                        final intValue = int.tryParse(value) ?? -1;
                        final maxBonusDays = (widget.vacationBalance / 3).floor();
                        
                        if (intValue == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SeniorSnackBar.warning(
                              message: context.translate.invalidVacationBonusDays,
                            ),
                          );
                        } else if (intValue > maxBonusDays) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SeniorSnackBar.warning(
                              message: context.translate.maxVacationBonusDays(maxBonusDays),
                            ),
                          );
                        }
                      },
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(bottom: SeniorSpacing.normal),
              child: SeniorTextField(
                controller: widget.notesController,
                label: context.translate.notes,
                counterText: context.translate.characters,
                showCounterText: true,
                maxLength: 255,
                maxLines: !canVacationBonus && !canChristmasBonus ? 3 : 1,
                style: const SeniorTextFieldStyle(
                  hintTextColor: SeniorColors.neutralColor900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDate() {
    FocusScope.of(context).unfocus();

    SeniorCalendar(
      margin: const EdgeInsets.only(
        bottom: SeniorSpacing.normal,
      ),
      inactiveYesterdays: true,
      calendarTitle: context.translate.startDateVacation,
      bottomText: context.translate.startDateVacationHelper,
      firstDay: DateTime(DateTime.now().year - 2, 1, 1),
      lastDay: DateTime(DateTime.now().year + 2, 12, 31),
      highlightToday: true,
      locale: LocaleHelper.languageAndCountryCode(
        locale: Localizations.localeOf(context),
      ),
      selectedDay: widget.selectedDate ?? DateTime.now(),
      onDaySelected: (date) {
        final formattedDate = DateTimeHelper.formatWithDefaultDatePattern(
          locale: LocaleHelper.languageAndCountryCode(
            locale: Localizations.localeOf(context),
          ),
          dateTime: date,
        );
        widget.dateController.text = formattedDate;
        widget.onDateChanged(date);
        Modular.to.pop();
      },
    ).pickCalendar(context);
  }
}
