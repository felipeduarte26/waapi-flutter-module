import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../components/senior_backdrop/themes/light/light_themes.dart';
import '../../components/senior_balance/themes/light/light_themes.dart';
import '../../components/senior_bottom_navigation_bar/themes/light/light_themes.dart';
import '../../components/senior_bottom_sheet/themes/light/light_themes.dart';
import '../../components/senior_button/themes/light/light_themes.dart';
import '../../components/senior_calendar/themes/light/light_themes.dart';
import '../../components/senior_card/themes/light/light_themes.dart';
import '../../components/senior_carousel_slider/themes/light/light_themes.dart';
import '../../components/senior_checkbox/themes/light/light_themes.dart';
import '../../components/senior_colorful_header_structure/themes/light/light_themes.dart';
import '../../components/senior_contact_book_item/themes/light/light_themes.dart';
import '../../components/senior_drawer/themes/light/light_themes.dart';
import '../../components/senior_dropdown_button/themes/light/light_themes.dart';
import '../../components/senior_expandable_list/themes/light/light_themes.dart';
import '../../components/senior_expansion_panel_list/themes/light/light_themes.dart';
import '../../components/senior_gradient_icon/themes/light/light_themes.dart';
import '../../components/senior_icon/themes/light/light_themes.dart';
import '../../components/senior_icon_button/themes/light/light_themes.dart';
import '../../components/senior_list/themes/light/light_themes.dart';
import '../../components/senior_image_cropper/themes/light/light_themes.dart';
import '../../components/senior_info_card/themes/light/light_themes.dart';
import '../../components/senior_loading/themes/light/light_themes.dart';
import '../../components/senior_circular_long_press_button/themes/light/light_themes.dart';
import '../../components/senior_message_card/themes/light/light_themes.dart';
import '../../components/senior_menu_list_item/themes/light/light_themes.dart';
import '../../components/senior_modal/themes/light/light_themes.dart';
import '../../components/senior_notification_list/themes/light/light_themes.dart';
import '../../components/senior_notification_snackbar/themes/light/light_themes.dart';
import '../../components/senior_pin_code_field/themes/light/light_themes.dart';
import '../../components/senior_profile_picture/themes/light/light_themes.dart';
import '../../components/senior_progress_bar/themes/light/light_themes.dart';
import '../../components/senior_quotes/themes/light/light_themes.dart';
import '../../components/senior_radio_button/themes/light/light_themes.dart';
import '../../components/senior_rating/themes/light/light_themes.dart';
import '../../components/senior_signature/themes/light/light_themes.dart';
import '../../components/senior_slide_to_act/themes/light/light_themes.dart';
import '../../components/senior_slider_dots/themes/light/light_themes.dart';
import '../../components/senior_snackbar/themes/light/light_themes.dart';
import '../../components/senior_square_buttons_menu/themes/light/light_themes.dart';
import '../../components/senior_state_page/themes/light/light_themes.dart';
import '../../components/senior_stepper/themes/light/light_themes.dart';
import '../../components/senior_success_animation/themes/light/light_themes.dart';
import '../../components/senior_switch/themes/light/light_themes.dart';
import '../../components/senior_tab_bar/themes/light/light_themes.dart';
import '../../components/senior_text/themes/light/_text_light.dart';
import '../../components/senior_text_field/themes/light/light_themes.dart';
import '../../components/senior_timeline/themes/light/light_themes.dart';

import '../senior_theme_data.dart';

/// Original light design system theme for the components.
final SENIOR_LIGHT_THEME = SeniorThemeData(
  themeType: ThemeType.light,
  backdropTheme: backdropLightTheme,
  balanceTheme: balanceLightTheme,
  bottomSheetTheme: bottomSheetLightTheme,
  bottomNavigationBarTheme: bottomNavigationBarLightTheme,
  primaryButtonTheme: primaryButtonLightTheme,
  secondaryButtonTheme: secondaryButtonLightTheme,
  ghostButtonTheme: ghostButtonLightTheme,
  calendarTheme: calendarLightTheme,
  cardTheme: cardLightTheme,
  carouselSliderTheme: carouselSliderLightTheme,
  checkboxTheme: checkboxLightTheme,
  colorfulHeaderStructureTheme: colorfulHeaderStructureLightTheme,
  contactBookItemTheme: contactBookItemLightTheme,
  drawerTheme: drawerLightTheme,
  dropdownButtonTheme: dropdownButtonLightTheme,
  expandableListTheme: expandableListLightTheme,
  expansionPanelListTheme: expansionPanelListLightTheme,
  gradientIconTheme: gradientIconLightTheme,
  primaryIconButtonTheme: primaryIconButtonLightTheme,
  secondaryIconButtonTheme: secondaryIconButtonLightTheme,
  ghostIconButtonTheme: ghostIconButtonLightTheme,
  dangerIconButtonTheme: dangerIconButtonLightTheme,
  iconTheme: iconLightTheme,
  imageCropperTheme: imageCropperLightTheme,
  infoCardTheme: infoCardLightTheme,
  listTheme: listLightTheme,
  loadingTheme: loadingLightTheme,
  longPressButtonTheme: circularLongPressButtonLightTheme,
  messageCardTheme: messageCardLightTheme,
  menuListItemTheme: menuListItemLightTheme,
  modalTheme: modalLightTheme,
  notificationListTheme: notificationListLightTheme,
  notificationSnackbarTheme: notificationSnackbarLightTheme,
  pinCodeFieldTheme: pinCodeFieldLightTheme,
  profilePictureTheme: profilePictureLightTheme,
  progressBarTheme: progressBarLightTheme,
  quotesTheme: quotesLightTheme,
  radioButtonTheme: radioButtonLightTheme,
  ratingTheme: ratingLightTheme,
  signatureTheme: signatureLightTheme,
  slideToActTheme: slideToActLightTheme,
  sliderDotsTheme: sliderDotsLightTheme,
  successSnackbarTheme: successSnackbarLightTheme,
  messageSnackbarTheme: messageSnackbarLightTheme,
  warningSnackbarTheme: warningSnackbarLightTheme,
  errorSnackbarTheme: errorSnackbarLightTheme,
  emphasisSquareButtonsMenuTheme: emphasisSquareButtonsMenuLightTheme,
  emphasisNegativeSquareButtonsMenuTheme: emphasisNegativeSquareButtonsMenuLightTheme,
  neutralSquareButtonsMenuTheme: neutralSquareButtonsMenuLightTheme,
  neutralNegativeSquareButtonsMenuTheme: neutralNegativeSquareButtonsMenuLightTheme,
  ghostSquareButtonsMenuTheme: ghostSquareButtonsMenuLightTheme,
  ghostNegativeSquareButtonsMenuTheme: ghostNegativeSquareButtonsMenuLightTheme,
  statePageTheme: statePageLightTheme,
  stepperTheme: stepperLightTheme,
  successAnimationTheme: successAnimationLightTheme,
  switchTheme: switchLightTheme,
  tabBarTheme: tabBarLightTheme,
  textTheme: textLightTheme,
  textFieldTheme: textFieldLightTheme,
  timelineTheme: timelineLightTheme,
  themeData: ThemeData(
    appBarTheme: AppBarTheme(
      titleTextStyle: SeniorTypography.label(color: SeniorColors.grayscale0),
      iconTheme: const IconThemeData(
        color: SeniorColors.grayscale0,
        size: 20.0,
      ),
      actionsIconTheme: const IconThemeData(
        color: SeniorColors.grayscale0,
        size: 20.0,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SeniorRadius.xbig),
      ),
    ),
    primaryColor: SeniorColors.primaryColor,
  ),
);
