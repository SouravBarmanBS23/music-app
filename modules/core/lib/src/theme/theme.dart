import 'package:flutter/material.dart';

import 'data/data.dart';

export './data/colors.dart';
export './data/data.dart';
export './data/padding.dart';
export './data/spacing.dart';
export './data/typography.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({
    required super.child,
    required this.themeData,
    super.key,
  });

  final UIThemeData themeData;

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return oldWidget.themeData != themeData;
  }

  static UIThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.themeData;
  }
}
