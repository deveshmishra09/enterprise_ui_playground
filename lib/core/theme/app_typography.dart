import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/breakpoints.dart';

/// Responsive text styles. Every style resolves its size from the current
/// [DeviceClass], so callers just do `AppText.h1(context)`.
///
/// Family is Inter via `google_fonts` (decision R12); swap `_family` to change
/// it everywhere.
abstract final class AppText {
  static TextStyle _family(TextStyle style) => GoogleFonts.inter(textStyle: style);

  static TextStyle _resolve(
    BuildContext context, {
    required double phone,
    required double tablet,
    required double desktop,
    required FontWeight weight,
    double? letterSpacing,
    double height = 1.3,
  }) {
    return _family(
      TextStyle(
        fontSize: context.responsive(
          phone: phone,
          tablet: tablet,
          desktop: desktop,
        ),
        fontWeight: weight,
        letterSpacing: letterSpacing,
        height: height,
      ),
    );
  }

  /// Slot 2 headline — the largest text on the site.
  static TextStyle display(BuildContext c) => _resolve(
    c,
    phone: 34,
    tablet: 44,
    desktop: 56,
    weight: FontWeight.w700,
    height: 1.05,
  );

  /// Section headings: "Explore the flows", "Have any questions?".
  static TextStyle h1(BuildContext c) => _resolve(
    c,
    phone: 28,
    tablet: 34,
    desktop: 40,
    weight: FontWeight.w700,
    height: 1.1,
  );

  static TextStyle h2(BuildContext c) => _resolve(
    c,
    phone: 22,
    tablet: 24,
    desktop: 28,
    weight: FontWeight.w700,
    height: 1.15,
  );

  /// Card titles, FAQ questions.
  static TextStyle h3(BuildContext c) => _resolve(
    c,
    phone: 18,
    tablet: 19,
    desktop: 20,
    weight: FontWeight.w600,
    height: 1.2,
  );

  static TextStyle body(BuildContext c) => _resolve(
    c,
    phone: 15,
    tablet: 16,
    desktop: 16,
    weight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodySmall(BuildContext c) => _resolve(
    c,
    phone: 13,
    tablet: 14,
    desktop: 14,
    weight: FontWeight.w400,
    height: 1.5,
  );

  /// Uppercase, letter-spaced labels.
  static TextStyle eyebrow(BuildContext c) => _resolve(
    c,
    phone: 12,
    tablet: 13,
    desktop: 13,
    weight: FontWeight.w600,
    letterSpacing: 1.5,
  );

  static TextStyle button(BuildContext c) => _resolve(
    c,
    phone: 15,
    tablet: 15,
    desktop: 15,
    weight: FontWeight.w600,
  );
}
