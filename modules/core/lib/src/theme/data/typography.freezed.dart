// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'typography.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UITextStyle {
  TextStyle get titleBS32 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UITextStyleCopyWith<UITextStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UITextStyleCopyWith<$Res> {
  factory $UITextStyleCopyWith(
          UITextStyle value, $Res Function(UITextStyle) then) =
      _$UITextStyleCopyWithImpl<$Res, UITextStyle>;
  @useResult
  $Res call({TextStyle titleBS32});
}

/// @nodoc
class _$UITextStyleCopyWithImpl<$Res, $Val extends UITextStyle>
    implements $UITextStyleCopyWith<$Res> {
  _$UITextStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleBS32 = null,
  }) {
    return _then(_value.copyWith(
      titleBS32: null == titleBS32
          ? _value.titleBS32
          : titleBS32 // ignore: cast_nullable_to_non_nullable
              as TextStyle,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UITextStyleCopyWith<$Res>
    implements $UITextStyleCopyWith<$Res> {
  factory _$$_UITextStyleCopyWith(
          _$_UITextStyle value, $Res Function(_$_UITextStyle) then) =
      __$$_UITextStyleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TextStyle titleBS32});
}

/// @nodoc
class __$$_UITextStyleCopyWithImpl<$Res>
    extends _$UITextStyleCopyWithImpl<$Res, _$_UITextStyle>
    implements _$$_UITextStyleCopyWith<$Res> {
  __$$_UITextStyleCopyWithImpl(
      _$_UITextStyle _value, $Res Function(_$_UITextStyle) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titleBS32 = null,
  }) {
    return _then(_$_UITextStyle(
      titleBS32: null == titleBS32
          ? _value.titleBS32
          : titleBS32 // ignore: cast_nullable_to_non_nullable
              as TextStyle,
    ));
  }
}

/// @nodoc

class _$_UITextStyle implements _UITextStyle {
  const _$_UITextStyle(
      {this.titleBS32 = const TextStyle(
          fontSize: 32, fontWeight: FontWeight.w700, height: 1)});

  @override
  @JsonKey()
  final TextStyle titleBS32;

  @override
  String toString() {
    return 'UITextStyle(titleBS32: $titleBS32)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UITextStyle &&
            (identical(other.titleBS32, titleBS32) ||
                other.titleBS32 == titleBS32));
  }

  @override
  int get hashCode => Object.hash(runtimeType, titleBS32);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UITextStyleCopyWith<_$_UITextStyle> get copyWith =>
      __$$_UITextStyleCopyWithImpl<_$_UITextStyle>(this, _$identity);
}

abstract class _UITextStyle implements UITextStyle {
  const factory _UITextStyle({final TextStyle titleBS32}) = _$_UITextStyle;

  @override
  TextStyle get titleBS32;
  @override
  @JsonKey(ignore: true)
  _$$_UITextStyleCopyWith<_$_UITextStyle> get copyWith =>
      throw _privateConstructorUsedError;
}
