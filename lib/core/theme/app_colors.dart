import 'package:flutter/widgets.dart';

/// The single source of truth for every color in the app.
///
/// Primary is `#af3a4a` (decision from the project brief). No other file should
/// hardcode a hex value — pull from here or from `Theme.of(context).colorScheme`.
abstract final class AppColors {
  // --- Brand -----------------------------------------------------------------
  static const Color primary = Color(0xFFAF3A4A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryHover = Color(0xFF9C333F);
  static const Color primaryTint = Color(0xFFE9C4C9);

  /// Faint primary wash — highlight behind "for FlutterUI", hover fills.
  static const Color primarySoft = Color(0x1FAF3A4A); // ~12% alpha

  // --- Dark hero band (Contact / Privacy / Terms) — decision R8 -------------
  static const Color inkBand = Color(0xFF141416);
  static const Color inkBandText = Color(0xFFE4E4E2);

  // --- Light theme neutrals ------------------------------------------------
  /// Warm paper base (matches withanimation.app's landing background).
  static const Color lightBackground = Color(0xFFF3EFE8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceMuted = Color(0xFFF6F6F5);
  static const Color lightOutline = Color(0xFFE4E4E2);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF5B5B5B);

  // --- Dark theme neutrals -----------------------------------------------
  /// Warm near-black base (matches withanimation.app's landing background).
  static const Color darkBackground = Color(0xFF100E0D);
  static const Color darkSurface = Color(0xFF161618);
  static const Color darkSurfaceMuted = Color(0xFF1D1D20);
  static const Color darkOutline = Color(0xFF2C2C30);
  static const Color darkTextPrimary = Color(0xFFF4F4F5);
  static const Color darkTextSecondary = Color(0xFFA1A1AA);

  // --- Shared ----------------------------------------------------------------
  /// Uppercase eyebrow labels ("BUILT WITH FLUTTER", column headings).
  static const Color eyebrow = Color(0xFF8A8A8A);

  /// Bezel of the device-frame preview (Slot 3b).
  static const Color deviceBezel = Color(0xFF17171A);

  /// Muted surface (cards, footer band) for the given brightness.
  static Color mutedSurfaceFor(Brightness brightness) =>
      brightness == Brightness.dark ? darkSurfaceMuted : lightSurfaceMuted;
}
