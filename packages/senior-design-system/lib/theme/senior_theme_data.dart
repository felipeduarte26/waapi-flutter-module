import 'package:flutter/material.dart';

import '../components/senior_backdrop/senior_backdrop.dart';
import '../components/senior_balance/senior_balance_theme.dart';
import '../components/senior_bottom_navigation_bar/senior_bottom_navigation_bar_theme.dart';
import '../components/senior_bottom_sheet/senior_bottom_sheet_theme.dart';
import '../components/senior_button/senior_button_theme.dart';
import '../components/senior_calendar/senior_calendar_theme.dart';
import '../components/senior_card/senior_card_theme.dart';
import '../components/senior_carousel_slider/senior_carousel_slider.dart';
import '../components/senior_checkbox/senior_checkbox_theme.dart';
import '../components/senior_circular_long_press_button/senior_circular_long_press_button.dart';
import '../components/senior_colorful_header_structure/senior_colorful_header_structure_theme.dart';
import '../components/senior_contact_book_item/senior_contact_book_item.dart';
import '../components/senior_drawer/senior_drawer.dart';
import '../components/senior_dropdown_button/senior_dropdown_button.dart';
import '../components/senior_expandable_list/senior_expandable_list_theme.dart';
import '../components/senior_expansion_panel_list/senior_expansion_panel_list.dart';
import '../components/senior_gradient_icon/senior_gradient_icon.dart';
import '../components/senior_icon/senior_icon_theme.dart';
import '../components/senior_icon_button/senior_icon_button.dart';
import '../components/senior_image_cropper/senior_image_cropper.dart';
import '../components/senior_info_card/senior_info_card_theme.dart';
import '../components/senior_list/senior_list.dart';
import '../components/senior_loading/senior_loading_theme.dart';
import '../components/senior_menu_list_item/senior_menu_list_item_theme.dart';
import '../components/senior_message_card/senior_message_card_theme.dart';
import '../components/senior_modal/senior_modal.dart';
import '../components/senior_notification_list/senior_notification_list.dart';
import '../components/senior_notification_snackbar/senior_notification_snackbar.dart';
import '../components/senior_pin_code_field/senior_pin_code_field.dart';
import '../components/senior_profile_picture/senior_profile_picture.dart';
import '../components/senior_progress_bar/senior_progress_bar.dart';
import '../components/senior_quotes/senior_quotes.dart';
import '../components/senior_radio_button/senior_radio_button_theme.dart';
import '../components/senior_rating/senior_rating_theme.dart';
import '../components/senior_signature/senior_signature_theme.dart';
import '../components/senior_slide_to_act/senior_slide_to_act.dart';
import '../components/senior_slider_dots/senior_slider_dots.dart';
import '../components/senior_snackbar/senior_snackbar_theme.dart';
import '../components/senior_square_buttons_menu/senior_square_buttons_menu_theme.dart';
import '../components/senior_state_page/senior_state_page.dart';
import '../components/senior_stepper/senior_stepper_theme.dart';
import '../components/senior_success_animation/senior_success_animation.dart';
import '../components/senior_switch/senior_switch_theme.dart';
import '../components/senior_tab_bar/senior_tab_bar.dart';
import '../components/senior_text/senior_text.dart';
import '../components/senior_text_field/senior_text_field.dart';
import '../components/senior_timeline/senior_timeline.dart';

class SeniorThemeData {
  /// Theme data class for the Senior design system components and Material design.
  /// The [themeType] parameter is required.
  const SeniorThemeData({
    required this.themeType,
    this.backdropTheme,
    this.balanceTheme,
    this.bottomNavigationBarTheme,
    this.bottomSheetTheme,
    this.primaryButtonTheme,
    this.secondaryButtonTheme,
    this.ghostButtonTheme,
    this.calendarTheme,
    this.cardTheme,
    this.carouselSliderTheme,
    this.checkboxTheme,
    this.colorfulHeaderStructureTheme,
    this.contactBookItemTheme,
    this.drawerTheme,
    this.dropdownButtonTheme,
    this.expandableListTheme,
    this.expansionPanelListTheme,
    this.gradientIconTheme,
    this.primaryIconButtonTheme,
    this.secondaryIconButtonTheme,
    this.ghostIconButtonTheme,
    this.dangerIconButtonTheme,
    this.iconTheme,
    this.imageCropperTheme,
    this.infoCardTheme,
    this.listTheme,
    this.loadingTheme,
    this.longPressButtonTheme,
    this.menuListItemTheme,
    this.messageCardTheme,
    this.modalTheme,
    this.notificationListTheme,
    this.notificationSnackbarTheme,
    this.pinCodeFieldTheme,
    this.profilePictureTheme,
    this.progressBarTheme,
    this.quotesTheme,
    this.radioButtonTheme,
    this.ratingTheme,
    this.signatureTheme,
    this.slideToActTheme,
    this.sliderDotsTheme,
    this.successSnackbarTheme,
    this.messageSnackbarTheme,
    this.warningSnackbarTheme,
    this.errorSnackbarTheme,
    this.emphasisSquareButtonsMenuTheme,
    this.emphasisNegativeSquareButtonsMenuTheme,
    this.neutralSquareButtonsMenuTheme,
    this.neutralNegativeSquareButtonsMenuTheme,
    this.ghostSquareButtonsMenuTheme,
    this.ghostNegativeSquareButtonsMenuTheme,
    this.statePageTheme,
    this.stepperTheme,
    this.successAnimationTheme,
    this.switchTheme,
    this.tabBarTheme,
    this.textTheme,
    this.textFieldTheme,
    this.timelineTheme,
    this.themeData,
    this.primaryColor,
    this.secondaryColor,
  });

  final ThemeType themeType;
  final SeniorBackdropThemeData? backdropTheme;
  final SeniorBalanceThemeData? balanceTheme;
  final SeniorBottomNavigationBarThemeData? bottomNavigationBarTheme;
  final SeniorBottomSheetThemeData? bottomSheetTheme;
  final SeniorButtonThemeData? primaryButtonTheme;
  final SeniorButtonThemeData? secondaryButtonTheme;
  final SeniorButtonThemeData? ghostButtonTheme;
  final SeniorCalendarThemeData? calendarTheme;
  final SeniorCardThemeData? cardTheme;
  final SeniorCarouselSliderThemeData? carouselSliderTheme;
  final SeniorCheckboxThemeData? checkboxTheme;
  final SeniorColorfulHeaderStructureThemeData? colorfulHeaderStructureTheme;
  final SeniorContactBookItemThemeData? contactBookItemTheme;
  final SeniorDrawerThemeData? drawerTheme;
  final SeniorDropdownButtonThemeData? dropdownButtonTheme;
  final SeniorExpandableListThemeData? expandableListTheme;
  final SeniorExpansionPanelListThemeData? expansionPanelListTheme;
  final SeniorGradientIconThemeData? gradientIconTheme;
  final SeniorIconThemeData? iconTheme;
  final SeniorIconButtonThemeData? primaryIconButtonTheme;
  final SeniorIconButtonThemeData? secondaryIconButtonTheme;
  final SeniorIconButtonThemeData? ghostIconButtonTheme;
  final SeniorIconButtonThemeData? dangerIconButtonTheme;
  final SeniorImageCropperThemeData? imageCropperTheme;
  final SeniorInfoCardThemeData? infoCardTheme;
  final SeniorListThemeData? listTheme;
  final SeniorLoadingThemeData? loadingTheme;
  final SeniorCircularLongPressButtonThemeData? longPressButtonTheme;
  final SeniorMenuListItemThemeData? menuListItemTheme;
  final SeniorMessageCardThemeData? messageCardTheme;
  final SeniorModalThemeData? modalTheme;
  final SeniorNotificationListThemeData? notificationListTheme;
  final SeniorNotificationSnackbarThemeData? notificationSnackbarTheme;
  final SeniorPinCodeFieldThemeData? pinCodeFieldTheme;
  final SeniorProfilePictureThemeData? profilePictureTheme;
  final SeniorProgressBarThemeData? progressBarTheme;
  final SeniorQuotesThemeData? quotesTheme;
  final SeniorRadioButtonThemeData? radioButtonTheme;
  final SeniorRatingThemeData? ratingTheme;
  final SeniorSignatureThemeData? signatureTheme;
  final SeniorSlideToActThemeData? slideToActTheme;
  final SeniorSliderDotsThemeData? sliderDotsTheme;
  final SeniorSnackbarThemeData? successSnackbarTheme;
  final SeniorSnackbarThemeData? messageSnackbarTheme;
  final SeniorSnackbarThemeData? warningSnackbarTheme;
  final SeniorSnackbarThemeData? errorSnackbarTheme;
  final SeniorSquareButtonsMenuThemeData? emphasisSquareButtonsMenuTheme;
  final SeniorSquareButtonsMenuThemeData? emphasisNegativeSquareButtonsMenuTheme;
  final SeniorSquareButtonsMenuThemeData? neutralSquareButtonsMenuTheme;
  final SeniorSquareButtonsMenuThemeData? neutralNegativeSquareButtonsMenuTheme;
  final SeniorSquareButtonsMenuThemeData? ghostSquareButtonsMenuTheme;
  final SeniorSquareButtonsMenuThemeData? ghostNegativeSquareButtonsMenuTheme;
  final SeniorStatePageThemeData? statePageTheme;
  final SeniorStepperThemeData? stepperTheme;
  final SeniorSuccessAnimationThemeData? successAnimationTheme;
  final SeniorSwitchThemeData? switchTheme;
  final SeniorTabBarThemeData? tabBarTheme;
  final SeniorTextThemeData? textTheme;
  final SeniorTextFieldThemeData? textFieldTheme;
  final SeniorTimelineThemeData? timelineTheme;
  final ThemeData? themeData;
  final Color? primaryColor;
  final Color? secondaryColor;

  SeniorThemeData copyWith({
    SeniorBackdropThemeData? backdropTheme,
    SeniorBalanceThemeData? balanceTheme,
    SeniorBottomNavigationBarThemeData? bottomNavigationBarTheme,
    SeniorBottomSheetThemeData? bottomSheetTheme,
    SeniorButtonThemeData? primaryButtonTheme,
    SeniorButtonThemeData? secondaryButtonTheme,
    SeniorButtonThemeData? ghostButtonTheme,
    SeniorCalendarThemeData? calendarTheme,
    SeniorCardThemeData? cardTheme,
    SeniorCarouselSliderThemeData? carouselSliderTheme,
    SeniorCheckboxThemeData? checkboxTheme,
    SeniorColorfulHeaderStructureThemeData? colorfulHeaderStructureTheme,
    SeniorContactBookItemThemeData? contactBookItemTheme,
    SeniorDropdownButtonThemeData? dropdownButtonTheme,
    SeniorDrawerThemeData? drawerTheme,
    SeniorExpandableListThemeData? expandableListTheme,
    SeniorExpansionPanelListThemeData? expansionPanelListTheme,
    SeniorGradientIconThemeData? gradientIconTheme,
    SeniorIconButtonThemeData? primaryIconButtonTheme,
    SeniorIconButtonThemeData? secondaryIconButtonTheme,
    SeniorIconButtonThemeData? ghostIconButtonTheme,
    SeniorIconButtonThemeData? dangerIconButtonTheme,
    SeniorIconThemeData? iconTheme,
    SeniorImageCropperThemeData? imageCropperTheme,
    SeniorInfoCardThemeData? infoCardTheme,
    SeniorListThemeData? listTheme,
    SeniorLoadingThemeData? loadingTheme,
    SeniorCircularLongPressButtonThemeData? longPressButtonTheme,
    SeniorMenuListItemThemeData? menuListItemTheme,
    SeniorMessageCardThemeData? messageCardTheme,
    SeniorModalThemeData? modalTheme,
    SeniorNotificationListThemeData? notificationListTheme,
    SeniorNotificationSnackbarThemeData? notificationSnackbarTheme,
    SeniorPinCodeFieldThemeData? pinCodeFieldTheme,
    SeniorProfilePictureThemeData? profilePictureTheme,
    SeniorProgressBarThemeData? progressBarTheme,
    SeniorQuotesThemeData? quotesTheme,
    SeniorRadioButtonThemeData? radioButtonTheme,
    SeniorRatingThemeData? ratingTheme,
    SeniorSignatureThemeData? signatureTheme,
    SeniorSlideToActThemeData? slideToActTheme,
    SeniorSliderDotsThemeData? sliderDotsTheme,
    SeniorSnackbarThemeData? successSnackbarTheme,
    SeniorSnackbarThemeData? messageSnackbarTheme,
    SeniorSnackbarThemeData? warningSnackbarTheme,
    SeniorSnackbarThemeData? errorSnackbarTheme,
    SeniorSquareButtonsMenuThemeData? emphasisSquareButtonsMenuTheme,
    SeniorSquareButtonsMenuThemeData? emphasisNegativeSquareButtonsMenuTheme,
    SeniorSquareButtonsMenuThemeData? neutralSquareButtonsMenuTheme,
    SeniorSquareButtonsMenuThemeData? neutralNegativeSquareButtonsMenuTheme,
    SeniorSquareButtonsMenuThemeData? ghostSquareButtonsMenuTheme,
    SeniorSquareButtonsMenuThemeData? ghostNegativeSquareButtonsMenuTheme,
    SeniorStatePageThemeData? statePageTheme,
    SeniorStepperThemeData? stepperTheme,
    SeniorSuccessAnimationThemeData? successAnimationTheme,
    SeniorSwitchThemeData? switchTheme,
    SeniorTabBarThemeData? tabBarTheme,
    SeniorTextThemeData? textTheme,
    SeniorTextFieldThemeData? textFieldTheme,
    SeniorTimelineThemeData? timelineTheme,
    ThemeData? themeData,
    Color? primaryColor,
    Color? secondaryColor,
    ThemeType? themeType,
  }) {
    return SeniorThemeData(
      themeType: themeType ?? this.themeType,
      backdropTheme: backdropTheme ?? this.backdropTheme,
      balanceTheme: balanceTheme ?? this.balanceTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme ?? this.bottomNavigationBarTheme,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
      primaryButtonTheme: primaryButtonTheme ?? this.primaryButtonTheme,
      secondaryButtonTheme: secondaryButtonTheme ?? this.secondaryButtonTheme,
      ghostButtonTheme: ghostButtonTheme ?? this.ghostButtonTheme,
      calendarTheme: calendarTheme ?? this.calendarTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      carouselSliderTheme: carouselSliderTheme ?? this.carouselSliderTheme,
      checkboxTheme: checkboxTheme ?? this.checkboxTheme,
      colorfulHeaderStructureTheme: colorfulHeaderStructureTheme ?? this.colorfulHeaderStructureTheme,
      contactBookItemTheme: contactBookItemTheme ?? this.contactBookItemTheme,
      drawerTheme: drawerTheme ?? this.drawerTheme,
      dropdownButtonTheme: dropdownButtonTheme ?? this.dropdownButtonTheme,
      expandableListTheme: expandableListTheme ?? this.expandableListTheme,
      expansionPanelListTheme: expansionPanelListTheme ?? this.expansionPanelListTheme,
      gradientIconTheme: gradientIconTheme ?? this.gradientIconTheme,
      primaryIconButtonTheme: primaryIconButtonTheme ?? this.primaryIconButtonTheme,
      secondaryIconButtonTheme: secondaryIconButtonTheme ?? this.secondaryIconButtonTheme,
      ghostIconButtonTheme: ghostIconButtonTheme ?? this.ghostIconButtonTheme,
      dangerIconButtonTheme: dangerIconButtonTheme ?? this.dangerIconButtonTheme,
      iconTheme: iconTheme ?? this.iconTheme,
      imageCropperTheme: imageCropperTheme ?? this.imageCropperTheme,
      infoCardTheme: infoCardTheme ?? this.infoCardTheme,
      listTheme: listTheme ?? this.listTheme,
      loadingTheme: loadingTheme ?? this.loadingTheme,
      longPressButtonTheme: longPressButtonTheme ?? this.longPressButtonTheme,
      menuListItemTheme: menuListItemTheme ?? this.menuListItemTheme,
      messageCardTheme: messageCardTheme ?? this.messageCardTheme,
      modalTheme: modalTheme ?? this.modalTheme,
      notificationListTheme: notificationListTheme ?? this.notificationListTheme,
      notificationSnackbarTheme: notificationSnackbarTheme ?? this.notificationSnackbarTheme,
      pinCodeFieldTheme: pinCodeFieldTheme ?? this.pinCodeFieldTheme,
      profilePictureTheme: profilePictureTheme ?? this.profilePictureTheme,
      progressBarTheme: progressBarTheme ?? this.progressBarTheme,
      quotesTheme: quotesTheme ?? this.quotesTheme,
      radioButtonTheme: radioButtonTheme ?? this.radioButtonTheme,
      ratingTheme: ratingTheme ?? this.ratingTheme,
      signatureTheme: signatureTheme ?? this.signatureTheme,
      slideToActTheme: slideToActTheme ?? this.slideToActTheme,
      sliderDotsTheme: sliderDotsTheme ?? this.sliderDotsTheme,
      successSnackbarTheme: successSnackbarTheme ?? this.successSnackbarTheme,
      messageSnackbarTheme: messageSnackbarTheme ?? this.messageSnackbarTheme,
      warningSnackbarTheme: warningSnackbarTheme ?? this.warningSnackbarTheme,
      errorSnackbarTheme: errorSnackbarTheme ?? this.errorSnackbarTheme,
      emphasisSquareButtonsMenuTheme: emphasisSquareButtonsMenuTheme ?? this.emphasisSquareButtonsMenuTheme,
      emphasisNegativeSquareButtonsMenuTheme:
          emphasisNegativeSquareButtonsMenuTheme ?? this.emphasisNegativeSquareButtonsMenuTheme,
      neutralSquareButtonsMenuTheme: neutralSquareButtonsMenuTheme ?? this.neutralSquareButtonsMenuTheme,
      neutralNegativeSquareButtonsMenuTheme:
          neutralNegativeSquareButtonsMenuTheme ?? this.neutralNegativeSquareButtonsMenuTheme,
      ghostSquareButtonsMenuTheme: ghostSquareButtonsMenuTheme ?? this.ghostSquareButtonsMenuTheme,
      ghostNegativeSquareButtonsMenuTheme:
          ghostNegativeSquareButtonsMenuTheme ?? this.ghostNegativeSquareButtonsMenuTheme,
      statePageTheme: statePageTheme ?? this.statePageTheme,
      stepperTheme: stepperTheme ?? this.stepperTheme,
      successAnimationTheme: successAnimationTheme ?? this.successAnimationTheme,
      switchTheme: switchTheme ?? this.switchTheme,
      tabBarTheme: tabBarTheme ?? this.tabBarTheme,
      textTheme: textTheme ?? this.textTheme,
      textFieldTheme: textFieldTheme ?? this.textFieldTheme,
      timelineTheme: timelineTheme ?? this.timelineTheme,
      themeData: themeData ?? this.themeData,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }
}

enum ThemeType { light, dark, custom }
