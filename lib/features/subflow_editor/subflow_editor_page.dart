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
        child: subFlow.isBuilt
            ? Builder(builder: subFlow.screenBuilder!)
            : ComingSoonScreen(
                flowTitle: flow.title,
                subFlowTitle: subFlow.title,
              ),
      ),
    );

    // The preview pane (second column) with the reset action pinned to its
    // top-right corner.
    final previewPane = Expanded(
      child: Stack(
        children: [
          Center(child: preview),
          Positioned(
            top: AppSpacing.xs,
            right: AppSpacing.xs,
            child: IconButton(
              tooltip: 'Refresh preview',
              onPressed: _resetPreview,
              icon: const Icon(Icons.refresh, color: AppColors.primary, size: 30),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SubflowResetScope(
        reset: _resetPreview,
        child: Column(
          children: [
            SiteHeader(
              variant: SiteHeaderVariant.preview,
              onBack: () => context.canPop()
                  ? context.pop()
                  : context.go('/flows/${flow.slug}'),
            ),
            Expanded(
              child: stacked
                  ? Column(
                      children: [
                        _ChipStrip(flow: flow, activeSlug: subFlow.slug),
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
                        previewPane,
                      ],
                    ),
            ),
          ],
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
