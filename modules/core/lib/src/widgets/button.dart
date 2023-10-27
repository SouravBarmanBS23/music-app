import 'package:core/src/extension/context_extension.dart';
import 'package:flutter/material.dart';

const double _kDefaultButtonHeight = 50;
const double _kDefaultButtonWidth = double.infinity;
const double _kDefaultButtonFontSize = 14;
const double _kDefaultLoadingIndicatorScale = 1;
const TextStyle _kDefaultLabelTextStyle = TextStyle(
  fontSize: _kDefaultButtonFontSize,
  fontWeight: FontWeight.w500,
);

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    this.background,
    this.textStyle,
    this.scale = _kDefaultLoadingIndicatorScale,
    this.height = _kDefaultButtonHeight,
    this.width = _kDefaultButtonWidth,
    this.isLoading = false,
    this.filled = true,
    this.prefix,
    this.disable = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final Color? background;
  final TextStyle? textStyle;
  final double scale;
  final double height;
  final double width;
  final bool filled;
  final bool isLoading;
  final Widget? prefix;
  final bool disable;

  factory Button.filled({
    required String label,
    required VoidCallback onPressed,
    Color? background,
    TextStyle? textStyle,
    double scale = _kDefaultLoadingIndicatorScale,
    double height = _kDefaultButtonHeight,
    double width = _kDefaultButtonWidth,
    bool isLoading = false,
    Widget? prefix,
    bool disable = false,
  }) {
    return Button(
      label: label,
      onPressed: onPressed,
      background: background,
      textStyle: textStyle,
      scale: scale,
      height: height,
      width: width,
      isLoading: isLoading,
      filled: true,
      prefix: prefix,
      disable: disable,
    );
  }

  factory Button.outlined({
    required String label,
    required VoidCallback onPressed,
    Color? background,
    TextStyle? textStyle,
    double scale = _kDefaultLoadingIndicatorScale,
    double height = _kDefaultButtonHeight,
    double width = _kDefaultButtonWidth,
    isLoading = false,
    Widget? prefix,
    bool disable = false,
  }) {
    return Button(
      label: label,
      onPressed: onPressed,
      background: background,
      textStyle: textStyle,
      scale: scale,
      height: height,
      width: width,
      isLoading: isLoading,
      filled: false,
      prefix: prefix,
      disable: disable,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = this.height;
    const double borderRadius = 10;

    return DecoratedBox(
      decoration: disable || filled == false
          ? const BoxDecoration()
          : BoxDecoration(
              color: context.color.trueBlue,
              /*gradient: LinearGradient(
                colors: [
                  context.theme.color.trueBlue,
                  context.theme.color.russianViolet,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),*/
              borderRadius: BorderRadius.circular(borderRadius),
            ),
      child: ElevatedButton(
        onPressed: disable
            ? null
            : isLoading
                ? null
                : onPressed,
        style: filled
            ? ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                fixedSize: Size(width, height),
                backgroundColor: background ?? context.theme.color.transparent,
                disabledBackgroundColor: context.color.disabled,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              )
            : ElevatedButton.styleFrom(
                elevation: 0,
                fixedSize: Size(width, height),
                backgroundColor: background ?? context.theme.color.transparent,
                disabledBackgroundColor: context.color.disabled,
                side: BorderSide(
                  color: isLoading
                      ? context.theme.color.transparent
                      : context.theme.color.white,
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? Transform.scale(
                    scale: scale,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : prefix == null
                    ? Text(
                        label,
                        style: textStyle ??
                            _kDefaultLabelTextStyle.copyWith(
                              color: context.theme.color.white,
                            ),
                      )
                    : Row(
                        children: [
                          prefix!,
                          const SizedBox(width: 10),
                          Text(
                            label,
                            style: textStyle ??
                                _kDefaultLabelTextStyle.copyWith(
                                  color: context.theme.color.white,
                                ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
