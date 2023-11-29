import 'package:core/src/theme/theme.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  UIThemeData get theme => AppTheme.of(this);

  UIColor get color => theme.color;

  UITextStyle get textStyle => theme.textStyle;
}
