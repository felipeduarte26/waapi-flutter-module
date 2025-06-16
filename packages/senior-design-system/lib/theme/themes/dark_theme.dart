import 'package:flutter/material.dart';

import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../components/senior_backdrop/themes/dark/dark_themes.dart';
import '../../components/senior_balance/themes/dark/dark_themes.dart';
import '../../components/senior_bottom_navigation_bar/themes/dark/dark_themes.dart';
import '../../components/senior_bottom_sheet/themes/dark/dark_themes.dart';
import '../../components/senior_button/themes/dark/dark_themes.dart';
import '../../components/senior_calendar/themes/dark/dark_themes.dart';
import '../../components/senior_card/themes/dark/dark_themes.dart';
import '../../components/senior_carousel_slider/themes/dark/dark_themes.dart';
import '../../components/senior_checkbox/themes/dark/dark_themes.dart';
import '../../components/senior_colorful_header_structure/themes/dark/dark_themes.dart';
import '../../components/senior_contact_book_item/themes/dark/dark_themes.dart';
import '../../components/senior_drawer/themes/dark/dark_themes.dart';
import '../../components/senior_dropdown_button/themes/dark/dark_themes.dart';
import '../../components/senior_expandable_list/themes/dark/dark_themes.dart';
import '../../components/senior_expansion_panel_list/themes/dark/dark_themes.dart';
import '../../components/senior_gradient_icon/themes/dark/dark_themes.dart';
import '../../components/senior_icon_button/themes/dark/dark_themes.dart';
import '../../components/senior_list/themes/dark/dark_themes.dart';
import '../../components/senior_icon/themes/dark/dark_themes.dart';
import '../../components/senior_image_cropper/themes/dark/dark_themes.dart';
import '../../components/senior_info_card/themes/dark/dark_themes.dart';
import '../../components/senior_loading/themes/dark/dark_themes.dart';
import '../../components/senior_circular_long_press_button/themes/dark/dark_themes.dart';
import '../../components/senior_message_card/themes/dark/dark_themes.dart';
import '../../components/senior_menu_list_item/themes/dark/dark_themes.dart';
import '../../components/senior_modal/themes/dark/dark_themes.dart';
import '../../components/senior_notification_list/themes/dark/dark_themes.dart';
import '../../components/senior_notification_snackbar/themes/dark/dark_themes.dart';
import '../../components/senior_pin_code_field/themes/dark/dark_themes.dart';
import '../../components/senior_profile_picture/themes/dark/dark_themes.dart';
import '../../components/senior_progress_bar/themes/dark/dark_themes.dart';
import '../../components/senior_quotes/themes/dark/dark_themes.dart';
import '../../components/senior_radio_button/themes/dark/dark_themes.dart';
import '../../components/senior_rating/themes/dark/dark_themes.dart';
import '../../components/senior_signature/themes/dark/dark_themes.dart';
import '../../components/senior_slide_to_act/themes/dark/dark_themes.dart';
import '../../components/senior_slider_dots/themes/dark/dark_themes.dart';
import '../../components/senior_snackbar/themes/dark/dark_themes.dart';
import '../../components/senior_square_buttons_menu/themes/dark/dark_themes.dart';
import '../../components/senior_state_page/themes/dark/dark_themes.dart';
import '../../components/senior_stepper/themes/dark/dark_themes.dart';
import '../../components/senior_success_animation/themes/dark/dark_themes.dart';
import '../../components/senior_switch/themes/dark/dark_themes.dart';
import '../../components/senior_tab_bar/themes/dark/dark_themes.dart';
import '../../components/senior_text/themes/dark/dark_themes.dart';
import '../../components/senior_text_field/themes/dark/dark_themes.dart';
import '../../components/senior_timeline/themes/dark/dark_themes.dart';

import '../senior_theme_data.dart';

/// Original dark design system theme for the components.
final SENIOR_DARK_THEME = SeniorThemeData(
  themeType: ThemeType.dark,
  backdropTheme: backdropDarkTheme,
  balanceTheme: balanceDarkTheme,
  bottomSheetTheme: bottomSheetDarkTheme,
  bottomNavigationBarTheme: bottomNavigationBarDarkTheme,
  primaryButtonTheme: primaryButtonDarkTheme,
  secondaryButtonTheme: secondaryButtonDarkTheme,
  ghostButtonTheme: ghostButtonDarkTheme,
  calendarTheme: calendarDarkTheme,
  cardTheme: cardDarkTheme,
  carouselSliderTheme: carouselSliderDarkTheme,
  checkboxTheme: checkboxDarkTheme,
  colorfulHeaderStructureTheme: colorfulHeaderStructureDarkTheme,
  contactBookItemTheme: contactBookItemDarkTheme,
  drawerTheme: drawerDarkTheme,
  dropdownButtonTheme: dropdownButtonDarkTheme,
  expandableListTheme: expandableListDarkTheme,
  expansionPanelListTheme: expansionPanelListDarkTheme,
  gradientIconTheme: gradientIconDarkTheme,
  primaryIconButtonTheme: primaryIconButtonDarkTheme,
  secondaryIconButtonTheme: secondaryIconButtonDarkTheme,
  ghostIconButtonTheme: ghostIconButtonDarkTheme,
  dangerIconButtonTheme: dangerIconButtonDarkTheme,
  iconTheme: iconDarkTheme,
  imageCropperTheme: imageCropperDarkTheme,
  infoCardTheme: infoCardDarkTheme,
  listTheme: listDarkTheme,
  loadingTheme: loadingDarkTheme,
  longPressButtonTheme: circularLongPressButtonDarkTheme,
  messageCardTheme: messageCardDarkTheme,
  menuListItemTheme: menuListItemDarkTheme,
  modalTheme: modalDarkTheme,
  notificationListTheme: notificationListDarkTheme,
  notificationSnackbarTheme: notificationSnackbarDarkTheme,
  pinCodeFieldTheme: pinCodeFieldDarkTheme,
  profilePictureTheme: profilePictureDarkTheme,
  progressBarTheme: progressBarDarkTheme,
  quotesTheme: quotesDarkTheme,
  radioButtonTheme: radioButtonDarkTheme,
  ratingTheme: ratingDarkTheme,
  signatureTheme: signatureDarkTheme,
  slideToActTheme: slideToActDarkTheme,
  sliderDotsTheme: sliderDotsDarkTheme,
  successSnackbarTheme: successSnackbarDarkTheme,
  messageSnackbarTheme: messageSnackbarDarkTheme,
  warningSnackbarTheme: warningSnackbarDarkTheme,
  errorSnackbarTheme: errorSnackbarDarkTheme,
  emphasisSquareButtonsMenuTheme: emphasisSquareButtonsMenuDarkTheme,
  emphasisNegativeSquareButtonsMenuTheme: emphasisNegativeSquareButtonsMenuDarkTheme,
  neutralSquareButtonsMenuTheme: neutralSquareButtonsMenuDarkTheme,
  neutralNegativeSquareButtonsMenuTheme: neutralNegativeSquareButtonsMenuDarkTheme,
  ghostSquareButtonsMenuTheme: ghostSquareButtonsMenuDarkTheme,
  ghostNegativeSquareButtonsMenuTheme: ghostNegativeSquareButtonsMenuDarkTheme,
  statePageTheme: statePageDarkTheme,
  stepperTheme: stepperDarkTheme,
  successAnimationTheme: successAnimationDarkTheme,
  switchTheme: switchDarkTheme,
  tabBarTheme: tabBarDarkTheme,
  textTheme: textDarkTheme,
  textFieldTheme: textFieldDarkTheme,
  timelineTheme: timelineDarkTheme,
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
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: SeniorColors.grayscale30),
      bodyMedium: TextStyle(color: SeniorColors.grayscale30),
      bodySmall: TextStyle(color: SeniorColors.grayscale30),
      displayLarge: TextStyle(color: SeniorColors.grayscale0),
      displayMedium: TextStyle(color: SeniorColors.grayscale30),
      displaySmall: TextStyle(color: SeniorColors.grayscale60),
      headlineLarge: TextStyle(color: SeniorColors.grayscale0),
      headlineMedium: TextStyle(color: SeniorColors.grayscale0),
      headlineSmall: TextStyle(color: SeniorColors.grayscale0),
      titleLarge: TextStyle(color: SeniorColors.grayscale0),
      titleMedium: TextStyle(color: SeniorColors.grayscale0),
      titleSmall: TextStyle(color: SeniorColors.grayscale0),
      labelLarge: TextStyle(color: SeniorColors.grayscale30),
      labelMedium: TextStyle(color: SeniorColors.grayscale30),
      labelSmall: TextStyle(color: SeniorColors.grayscale30),
    ),
  ),
);
