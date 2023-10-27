import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'colors.freezed.dart';

@freezed
class UIColor with _$UIColor {
  const factory UIColor({
    @Default(Colors.transparent) Color transparent,
    @Default(Colors.black) Color black,
    @Default(Colors.white) Color white,
    @Default(Color(0xFFC3C3C3)) Color silver,
    @Default(Color(0xFFEFF2F4)) Color antiFlashWhite,
    @Default(Color(0xFFC4C5C4)) Color disabled,
    @Default(Color(0xFF3669C9)) Color trueBlue,
    @Default(Color(0xFF3669C9)) Color russianViolet,
    @Default(Color(0xFFF8753D)) Color orange,
    @Default(Color(0xFF162432)) Color gunMetal,
    @Default(Color(0xFF878787)) Color battleshipGrey,
    @Default(Color(0xFFF5F5F5)) Color whiteSmoke,
    @Default(Color(0xFF1B3753)) Color prussianBlue,
    @Default(Color(0xFFD6D6D6)) Color timberWolf,
    @Default(Color(0xFF004973)) Color indigoDye,
    @Default(Color(0xFF9FE1F5)) Color nonPhotoBlue,
    @Default(Color(0xFF999999)) Color slateGray,
    @Default(Color(0xFFF0F5F8)) Color aliceBlue,
    @Default(Color(0xFFF5F5F5)) Color lightGray,
    @Default(Color(0xFF959E9F)) Color darkCadetGray,
    @Default(Color(0xFF4D4D4D)) Color davysGrey,
    @Default(Color(0xFF484A4A)) Color darkGray,
    @Default(Color(0xFFD5BBC7)) Color mauve,
    @Default(Color(0xFF17171A)) Color eerieBlack,
    @Default(Color(0xFF00132D)) Color oxfordBlue,
    @Default(Color(0xFFDADADA)) Color platinum,
    @Default(Color(0xFFE7EAED)) Color gainsboro,
    @Default(Color(0xFFFBFBFB)) Color snow,
  }) = _UIColor;
}
