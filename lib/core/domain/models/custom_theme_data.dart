import 'package:flutter/material.dart';

import '../models/models.dart';

class CustomThemeData {
  final AppThemeKey themeKey;
  final ThemeData themeData;
  final AdditionalThemeData additionalThemeData;

  const CustomThemeData(this.themeKey, this.themeData,
      {this.additionalThemeData});
}

class AdditionalThemeData {
  final Color startAppBackgroundGradientColor;
  final Color endAppBackgroundGradientColor;
  final Color startAppBarGradientColor;
  final Color endAppBarGradientColor;
  final Color elevationColor;
  final Color floatingActionButtonColor;
  final Color bottomNavigationBarActiveIconColor;
  final Color bottomNavigationBarDisableIconColor;
  final Color circularPercentIndicatorProgressColor;
  final Color circularPercentIndicatorBackgroundColor;
  final Color profileScreenBackgroundColor;
  final Color profileScreenCardBackgroundColor;
  final Color autocompleteSuggestionsDividerColor;

  AdditionalThemeData(
      {this.startAppBackgroundGradientColor,
      this.endAppBackgroundGradientColor,
      this.startAppBarGradientColor,
      this.endAppBarGradientColor,
      this.elevationColor,
      this.floatingActionButtonColor,
      this.bottomNavigationBarActiveIconColor,
      this.bottomNavigationBarDisableIconColor,
      this.circularPercentIndicatorProgressColor,
      this.circularPercentIndicatorBackgroundColor,
      this.profileScreenBackgroundColor,
      this.profileScreenCardBackgroundColor,
      this.autocompleteSuggestionsDividerColor});
}
