import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'padding.freezed.dart';

@freezed
class UIPadding with _$UIPadding {
  const factory UIPadding({
    @Default(EdgeInsets.all(4)) EdgeInsets p4,
    @Default(EdgeInsets.all(8)) EdgeInsets p8,
    @Default(EdgeInsets.all(12)) EdgeInsets p12,
    @Default(EdgeInsets.all(16)) EdgeInsets p16,
    @Default(EdgeInsets.all(20)) EdgeInsets p20,
    @Default(EdgeInsets.all(24)) EdgeInsets p24,
    @Default(EdgeInsets.all(28)) EdgeInsets p28,
    @Default(EdgeInsets.all(32)) EdgeInsets p32,
    @Default(EdgeInsets.all(36)) EdgeInsets p36,
    @Default(EdgeInsets.all(40)) EdgeInsets p40,
    @Default(EdgeInsets.all(44)) EdgeInsets p44,
    @Default(EdgeInsets.all(48)) EdgeInsets p48,
    @Default(EdgeInsets.all(52)) EdgeInsets p52,
    @Default(EdgeInsets.all(56)) EdgeInsets p56,
    @Default(EdgeInsets.all(60)) EdgeInsets p60,
    @Default(EdgeInsets.all(64)) EdgeInsets p64,
  }) = _UIPadding;
}
