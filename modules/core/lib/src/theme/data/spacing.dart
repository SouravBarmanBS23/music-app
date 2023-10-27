import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sizes.dart';
part 'spacing.freezed.dart';

@freezed
class UISpacing with _$UISpacing {
  const factory UISpacing({
    /// Heights and widths
    @Default(SizedBox(height: Sizes.s4, width: Sizes.s4)) SizedBox s4,
    @Default(SizedBox(height: Sizes.s8, width: Sizes.s8)) SizedBox s8,
    @Default(SizedBox(height: Sizes.s12, width: Sizes.s12)) SizedBox s12,
    @Default(SizedBox(height: Sizes.s16, width: Sizes.s16)) SizedBox s16,
    @Default(SizedBox(height: Sizes.s20, width: Sizes.s20)) SizedBox s20,
    @Default(SizedBox(height: Sizes.s24, width: Sizes.s24)) SizedBox s24,
    @Default(SizedBox(height: Sizes.s28, width: Sizes.s28)) SizedBox s28,
    @Default(SizedBox(height: Sizes.s32, width: Sizes.s32)) SizedBox s32,
    @Default(SizedBox(height: Sizes.s36, width: Sizes.s36)) SizedBox s36,
    @Default(SizedBox(height: Sizes.s40, width: Sizes.s40)) SizedBox s40,
    @Default(SizedBox(height: Sizes.s44, width: Sizes.s44)) SizedBox s44,
    @Default(SizedBox(height: Sizes.s48, width: Sizes.s48)) SizedBox s48,
    @Default(SizedBox(height: Sizes.s52, width: Sizes.s52)) SizedBox s52,
    @Default(SizedBox(height: Sizes.s56, width: Sizes.s56)) SizedBox s56,
    @Default(SizedBox(height: Sizes.s60, width: Sizes.s60)) SizedBox s60,
    @Default(SizedBox(height: Sizes.s64, width: Sizes.s64)) SizedBox s64,

    /// Heights
    @Default(SizedBox(height: Sizes.s4)) SizedBox h4,
    @Default(SizedBox(height: Sizes.s8)) SizedBox h8,
    @Default(SizedBox(height: Sizes.s12)) SizedBox h12,
    @Default(SizedBox(height: Sizes.s16)) SizedBox h16,
    @Default(SizedBox(height: Sizes.s20)) SizedBox h20,
    @Default(SizedBox(height: Sizes.s24)) SizedBox h24,
    @Default(SizedBox(height: Sizes.s28)) SizedBox h28,
    @Default(SizedBox(height: Sizes.s32)) SizedBox h32,
    @Default(SizedBox(height: Sizes.s36)) SizedBox h36,
    @Default(SizedBox(height: Sizes.s40)) SizedBox h40,
    @Default(SizedBox(height: Sizes.s44)) SizedBox h44,
    @Default(SizedBox(height: Sizes.s48)) SizedBox h48,
    @Default(SizedBox(height: Sizes.s52)) SizedBox h52,
    @Default(SizedBox(height: Sizes.s56)) SizedBox h56,
    @Default(SizedBox(height: Sizes.s60)) SizedBox h60,
    @Default(SizedBox(height: Sizes.s64)) SizedBox h64,

    /// Widths
    @Default(SizedBox(width: Sizes.s4)) SizedBox w4,
    @Default(SizedBox(width: Sizes.s8)) SizedBox w8,
    @Default(SizedBox(width: Sizes.s12)) SizedBox w12,
    @Default(SizedBox(width: Sizes.s16)) SizedBox w16,
    @Default(SizedBox(width: Sizes.s20)) SizedBox w20,
    @Default(SizedBox(width: Sizes.s24)) SizedBox w24,
    @Default(SizedBox(width: Sizes.s28)) SizedBox w28,
    @Default(SizedBox(width: Sizes.s32)) SizedBox w32,
    @Default(SizedBox(width: Sizes.s36)) SizedBox w36,
    @Default(SizedBox(width: Sizes.s40)) SizedBox w40,
    @Default(SizedBox(width: Sizes.s44)) SizedBox w44,
    @Default(SizedBox(width: Sizes.s48)) SizedBox w48,
    @Default(SizedBox(width: Sizes.s52)) SizedBox w52,
    @Default(SizedBox(width: Sizes.s56)) SizedBox w56,
    @Default(SizedBox(width: Sizes.s60)) SizedBox w60,
    @Default(SizedBox(width: Sizes.s64)) SizedBox w64,
  }) = _UISpacing;
}
