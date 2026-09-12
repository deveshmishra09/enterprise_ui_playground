import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:enterprise_ui_playground/core/constants/breakpoints.dart';
import 'package:enterprise_ui_playground/core/models/app_flow.dart';
import 'package:enterprise_ui_playground/core/models/sub_flow.dart';
import 'package:enterprise_ui_playground/core/navigation/subflow_reset_scope.dart';
import 'package:enterprise_ui_playground/core/theme/app_colors.dart';
import 'package:enterprise_ui_playground/core/theme/app_spacing.dart';
import 'package:enterprise_ui_playground/core/theme/app_typography.dart';
import 'package:enterprise_ui_playground/core/widgets/coming_soon_screen.dart';
import 'package:enterprise_ui_playground/core/widgets/device_frame_preview.dart';
import 'package:enterprise_ui_playground/core/widgets/site_header.dart';
import 'package:enterprise_ui_playground/features/subflow_editor/widgets/subflow_list_panel.dart';

/// Slot 3b — route `/flows/:flowSlug/:subFlowSlug`. Preview header, a list of the
/// flow's subflows, and a live [DeviceFramePreview] of the selected one. No
/// footer — this is a full-height workspace.
class SubflowEditorPage extends StatefulWidget {
  const SubflowEditorPage({
    super.key,
    required this.flow,
    required this.subFlow,
  });

  final AppFlow flow;
  final SubFlow subFlow;

  @override
  State<SubflowEditorPage> createState() => _SubflowEditorPageState();
}

class _SubflowEditorPageState extends State<SubflowEditorPage> {
  int _resetTick = 0;
  ScreenView _screenView = ScreenView.mobile;

  void _resetPreview() => setState(() => _resetTick++);

  @override
  Widget build(BuildContext context) {
    final flow = widget.flow;
    final subFlow = widget.subFlow;
    final width = MediaQuery.sizeOf(context).width;
    final stacked = width < Breakpoints.editorStackBelow;
    final railWidth = (width * 0.2).clamp(180.0, 320.0);

    final preview = Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: DeviceFramePreview(
        key: ValueKey('${subFlow.slug}-$_resetTick'),
        screenView: _screenView,
        child: subFlow.isBuilt
            ? Builder(builder: subFlow.screenBuilder!)
            : ComingSoonScreen(
                flowTitle: flow.title,
                subFlowTitle: subFlow.title,
              ),
      ),
    );

    // The preview pane (second column) — just the framed preview, centered.
    // The screen-view toggle and reset action live in the toolbar, never over
    // the preview content itself (R20: floating controls used to sit on top
    // of whatever was being previewed).
    final previewPane = Expanded(child: Center(child: preview));

    final toolbar = _WorkspaceToolbar(
      screenView: _screenView,
      onScreenViewChanged: (view) => setState(() => _screenView = view),
      onReset: _resetPreview,
    );

    // On the two-column (rail + preview) layout the toggle/reset live at the
    // top of the preview column specifically, not spanning the rail too:
    // the three screen-view buttons centered, the reset button pinned to the
    // column's own top-right corner.
    final previewColumnToolbar = _WorkspaceToolbar(
      screenView: _screenView,
      onScreenViewChanged: (view) => setState(() => _screenView = view),
      onReset: _resetPreview,
      centerToggleOnly: true,
    );

    return Scaffold(
      body: SubflowResetScope(
        reset: _resetPreview,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              SiteHeader(
                variant: SiteHeaderVariant.preview,
                onBack: () => context.canPop()
                    ? context.pop()
                    : context.go('/flows/${flow.slug}'),
              ),
              // On narrow/stacked screens the toolbar sits below the subflow
              // chip strip (R21), full width. On the two-column layout it
              // instead sits at the top of the preview column only (below).
              Expanded(
                child: stacked
                    ? Column(
                        children: [
                          _ChipStrip(flow: flow, activeSlug: subFlow.slug),
                          toolbar,
                          previewPane,
                        ],
                      )
                    : Row(
                        children: [
                          SizedBox(
                            width: railWidth,
                            child: SubflowListPanel(
                              flow: flow,
                              activeSlug: subFlow.slug,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [previewColumnToolbar, previewPane],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Narrow-layout replacement for the side rail: a horizontal scrolling strip.
class _ChipStrip extends StatelessWidget {
  const _ChipStrip({required this.flow, required this.activeSlug});

  final AppFlow flow;
  final String activeSlug;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          spacing: AppSpacing.sm,
          children: [
            for (final subFlow in flow.subFlows)
              _Chip(
                label: subFlow.title,
                isActive: subFlow.slug == activeSlug,
                onTap: () => context.go('/flows/${flow.slug}/${subFlow.slug}'),
              ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: isActive ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySoft : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          label,
          style: AppText.bodySmall(context).copyWith(
            color: isActive ? AppColors.primary : scheme.onSurface,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

/// The editor's own toolbar: the three screen-view buttons and the reset
/// button. A plain child of the outer [Column]/stacked layout (not a
/// floating overlay), so it can never sit on top of the header above it, the
/// subflow list beside it, or the preview below it (R20/R21) — it has its
/// own dedicated band, so it always fits even at narrow phone widths.
///
/// Two layouts:
/// * default — the toggle and reset button centered together as a pair
///   (narrow/stacked screens, where this is the only thing in its row).
/// * [centerToggleOnly] — the toggle centered across the *whole* row width
///   and the reset button pinned to the row's own right edge (the preview
///   column on the two-column layout, decision R23), via two equal-flex
///   spacers rather than [Alignment.center] on the pair, so the toggle's
///   centering never shifts based on the reset button's width.
class _WorkspaceToolbar extends StatelessWidget {
  const _WorkspaceToolbar({
    required this.screenView,
    required this.onScreenViewChanged,
    required this.onReset,
    this.centerToggleOnly = false,
  });

  final ScreenView screenView;
  final ValueChanged<ScreenView> onScreenViewChanged;
  final VoidCallback onReset;
  final bool centerToggleOnly;

  @override
  Widget build(BuildContext context) {
    final toggle = _ScreenViewToggle(
      value: screenView,
      onChanged: onScreenViewChanged,
    );
    final resetButton = IconButton(
      tooltip: 'Refresh preview',
      onPressed: onReset,
      icon: const Icon(Icons.refresh, color: AppColors.primary, size: 30),
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: centerToggleOnly
          ? Row(
              children: [
                const Expanded(child: SizedBox()),
                toggle,
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: resetButton,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.xs,
              children: [toggle, resetButton],
            ),
    );
  }
}

/// Mobile / Tablet / Web preview-size switcher.
class _ScreenViewToggle extends StatelessWidget {
  const _ScreenViewToggle({required this.value, required this.onChanged});

  final ScreenView value;
  final ValueChanged<ScreenView> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: SegmentedButton<ScreenView>(
        style: const ButtonStyle(
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(
            value: ScreenView.mobile,
            icon: Icon(Icons.smartphone, size: 18),
            tooltip: 'Mobile',
          ),
          ButtonSegment(
            value: ScreenView.tablet,
            icon: Icon(Icons.tablet_mac, size: 18),
            tooltip: 'Tablet',
          ),
          ButtonSegment(
            value: ScreenView.web,
            icon: Icon(Icons.language, size: 18),
            tooltip: 'Web',
          ),
        ],
        selected: {value},
        onSelectionChanged: (selection) => onChanged(selection.first),
      ),
    );
  }
}
