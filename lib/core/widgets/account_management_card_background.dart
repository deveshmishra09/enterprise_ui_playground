import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Decorative, pointer-reactive background for the Account Management
/// [FlowCard]: a handful of account/security icons drift toward the cursor
/// and brighten near it, plus a soft spotlight that follows the pointer.
///
/// Deliberately has no looping ticker — every transition is a bounded
/// [AnimatedPositioned]/[AnimatedOpacity], so it settles once the pointer
/// stops moving instead of animating forever (which would hang
/// `pumpAndSettle` in widget tests).
class AccountManagementCardBackground extends StatefulWidget {
  const AccountManagementCardBackground({super.key});

  @override
  State<AccountManagementCardBackground> createState() =>
      _AccountManagementCardBackgroundState();
}

class _AccountManagementCardBackgroundState
    extends State<AccountManagementCardBackground> {
  Offset? _pointer;

  static const List<IconData> _icons = <IconData>[
    Icons.person_outline,
    Icons.lock_outline,
    Icons.verified_user_outlined,
    Icons.switch_account_outlined,
  ];

  static const Duration _duration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final pointer = _pointer;
          return MouseRegion(
            onHover: (event) => setState(() => _pointer = event.localPosition),
            onExit: (_) => setState(() => _pointer = null),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeOut,
                  left: (pointer?.dx ?? size.width / 2) - 90,
                  top: (pointer?.dy ?? size.height / 2) - 90,
                  child: IgnorePointer(
                    child: AnimatedOpacity(
                      duration: _duration,
                      opacity: pointer == null ? 0 : 1,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.primary.withValues(alpha: 0.14),
                              AppColors.primary.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                for (var i = 0; i < _icons.length; i++)
                  _driftingIcon(size, i, pointer),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _driftingIcon(Size size, int index, Offset? pointer) {
    final base = Offset(
      size.width * (0.2 + 0.24 * (index % 2)) +
          size.width * 0.38 * (index ~/ 2),
      size.height * (index.isEven ? 0.28 : 0.68),
    );

    var opacity = 0.07;
    var center = base;
    if (pointer != null) {
      final toPointer = pointer - base;
      final distance = toPointer.distance;
      final proximity = 1 - (distance / 140).clamp(0.0, 1.0);
      opacity += proximity * 0.13;
      if (distance > 0) {
        // Nudge the icon a few px toward the cursor — the "magnetized" feel.
        center = base + toPointer * (0.08 * proximity);
      }
    }

    return AnimatedPositioned(
      duration: _duration,
      curve: Curves.easeOut,
      left: center.dx - 14,
      top: center.dy - 14,
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: _duration,
          opacity: opacity,
          child: Icon(_icons[index], size: 28, color: AppColors.primary),
        ),
      ),
    );
  }
}
