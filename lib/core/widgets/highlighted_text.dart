import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Renders [text] with the first occurrence of [highlight] painted in the accent
/// color on a faint primary wash — used for "for FlutterUI" in the Slot 2
/// headline. Falls back to a plain [Text] if [highlight] isn't found.
class HighlightedText extends StatelessWidget {
  const HighlightedText({
    super.key,
    required this.text,
    required this.highlight,
    required this.style,
    this.highlightStyle,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final String highlight;
  final TextStyle style;
  final TextStyle? highlightStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final index = text.indexOf(highlight);
    if (index < 0) {
      return Text(text, style: style, textAlign: textAlign);
    }

    final accent = highlightStyle ??
        style.copyWith(
          color: AppColors.primary,
          backgroundColor: AppColors.primarySoft,
        );

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text.substring(0, index), style: style),
          TextSpan(text: highlight, style: accent),
          TextSpan(text: text.substring(index + highlight.length), style: style),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
