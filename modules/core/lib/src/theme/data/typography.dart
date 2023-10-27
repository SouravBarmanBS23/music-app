import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'typography.freezed.dart';

@freezed
class UITextStyle with _$UITextStyle {
  const factory UITextStyle({
    @Default(
      TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    )
    TextStyle titleBS32,
  }) = _UITextStyle;
}
