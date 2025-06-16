import 'package:flutter/material.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

SeniorBottomNavigationBarThemeData createSeniorBottomNavigationBarStyle({required Color primaryColor}) {
  return bottomNavigationBarLightTheme.copyWith(
    style: bottomNavigationBarLightTheme.style?.copyWith(
      selectedItemColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
      badgeColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorButtonThemeData createPrimaryButtonStyle({required Color primaryColor}) {
  return primaryButtonLightTheme.copyWith(
    style: primaryButtonLightTheme.style?.copyWith(
      outlinedBorderColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor),
      backgroundColor: primaryColor,
      disabledBackgroundColor: primaryColor.withOpacity(0.2),
      contentColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor),
      disabledContentColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor).withOpacity(0.5),
      borderColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
      disabledBorderColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor).withOpacity(0.5),
      loaderColor: primaryColor,
      outlinedContentColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor),
      outlinedDisabledContentColor:
          SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor).withOpacity(0.5),
    ),
  );
}

SeniorButtonThemeData createGhostButtonStyle({required Color primaryColor}) {
  return primaryButtonLightTheme.copyWith(
    style: primaryButtonLightTheme.style?.copyWith(
      backgroundColor: Colors.transparent,
      contentColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
      loaderColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
      disabledContentColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor).withOpacity(0.5),
    ),
  );
}

SeniorColorfulHeaderStructureThemeData createSeniorColorfulHeaderStructureStyle({required Color headerColors}) {
  return colorfulHeaderStructureLightTheme.copyWith(
    style: colorfulHeaderStructureLightTheme.style?.copyWith(
      headerColors: [
        headerColors,
        headerColors,
      ],
    ),
  );
}

SeniorMenuListItemThemeData createMenuListItemStyle({required Color primaryColor}) {
  return menuListItemLightTheme.copyWith(
    style: menuListItemLightTheme.style?.copyWith(
      iconColor: primaryColor,
      pushIconColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorGradientIconThemeData createGradientIconStyle({required Color primaryColor, required Color? secondaryColor}) {
  return gradientIconLightTheme.copyWith(
    style: gradientIconLightTheme.style?.copyWith(
      gradientColors: [
        primaryColor,
        primaryColor,
      ],
    ),
  );
}

SeniorBottomSheetThemeData createBottomSheetStyle({required Color primaryColor}) {
  return bottomSheetLightTheme.copyWith(
    style: bottomSheetLightTheme.style?.copyWith(
      closeButtonColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorIconThemeData createCustomIconStyle({required Color primaryColor, required ThemeType themeStyle}) {
  return iconLightTheme.copyWith(
    style: iconLightTheme.style?.copyWith(
      color: primaryColor,
    ),
  );
}

SeniorCalendarThemeData createCustomCalendarTheme({required Color primaryColor}) {
  return SeniorCalendarThemeData(
    style: calendarLightStyle.copyWith(
      colorCircleDefaultMarkedDay: SeniorColors.primaryColor600,
      selectedDayColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor),
      selectedDayBackgroundColor: primaryColor.withOpacity(0.3),
    ),
  );
}

SeniorDropdownButtonThemeData createCustomDropdownButtonStyle({required Color primaryColor}) {
  return SeniorDropdownButtonThemeData(
    style: dropdownButtonLightStyle.copyWith(
      labelColorFilled: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorTextFieldThemeData createCustomTextFieldTheme({required Color primaryColor}) {
  return SeniorTextFieldThemeData(
    style: textFieldLightStyle.copyWith(
      focusColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorIconStyle createIconStyle({required Color color}) {
  return iconLightTheme.style!.copyWith(
    color: SeniorServiceColor.getContrastAdjustedColorTheme(color: color),
  );
}

SeniorRadioButtonThemeData createRadioButtonStyle({required Color primaryColor}) {
  return radioButtonLightTheme.copyWith(
    style: radioButtonLightTheme.style?.copyWith(
      checkedFillColor: SeniorServiceColor.getContrastAdjustedColorTheme(
        color: primaryColor,
      ),
      uncheckedFillColor: SeniorServiceColor.getContrastAdjustedColorTheme(
        color: primaryColor,
      ),
    ),
  );
}

SeniorCheckboxThemeData createCustomCheckboxStyle({required Color primaryColor}) {
  return SeniorCheckboxThemeData(
    style: checkboxLightStyle.copyWith(
      checkColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
      checkedBorderColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorLoadingThemeData createLoadingStyle({required Color primaryColor}) {
  return loadingLightTheme.copyWith(
    style: loadingLightTheme.style?.copyWith(
      color: SeniorServiceColor.getContrastAdjustedColorTheme(
        color: primaryColor,
      ),
    ),
  );
}

SeniorSquareButtonsMenuThemeData createNeutralSquareButtonsStyle({required Color primaryColor}) {
  return neutralSquareButtonsMenuLightTheme.copyWith(
    style: neutralSquareButtonsMenuLightTheme.style?.copyWith(
      backgroundColor: primaryColor,
      borderColor: primaryColor,
      fontColor: SeniorServiceColor.getOptimalContrastColorTheme(color: primaryColor),
      iconColor: SeniorServiceColor.getColorSquareButtonsTheme(
        color: primaryColor,
      ),
      disabledBackgroundColor: primaryColor.withOpacity(0.5),
      disabledBorderColor: primaryColor.withOpacity(0.5),
      disabledFontColor: SeniorServiceColor.getColorSquareButtonsTheme(
        color: primaryColor,
        isDisabled: true,
      ),
      disabledIconColor: SeniorServiceColor.getColorSquareButtonsTheme(
        color: primaryColor,
        isDisabled: true,
      ),
    ),
  );
}

SeniorStepperThemeData createStepperStyle({required Color primaryColor}) {
  return SeniorStepperThemeData(
    style: stepperLightTheme.style?.copyWith(
      completedStepColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor).withOpacity(0.5),
      currentStepColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}

SeniorTabBarThemeData createTabBarStyle({required Color primaryColor}) {
  return tabBarLightTheme.copyWith(
    style: tabBarLightTheme.style?.copyWith(
      indicatorColor: SeniorServiceColor.getContrastAdjustedColorTheme(
        color: primaryColor,
      ),
    ),
  );
}

SeniorSwitchThemeData createSwitchStyle({required Color primaryColor}) {
  return switchLightTheme.copyWith(
    style: switchLightTheme.style?.copyWith(
      activeColor: SeniorServiceColor.getContrastAdjustedColorTheme(color: primaryColor),
    ),
  );
}
