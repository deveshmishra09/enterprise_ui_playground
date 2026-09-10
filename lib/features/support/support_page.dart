import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/widgets/info_page_scaffold.dart';
import 'package:enterprise_ui_playground/core/widgets/prose_sections.dart';

/// Route `/support`. Structure modelled on withanimation.app/support.
// TODO(copy): draft support content — finalize before launch (decision R4).
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPageScaffold(
      eyebrow: 'SUPPORT',
      title: 'Help & support',
      intro:
          'Answers to the questions that come up most, and how to reach a human '
          'when they do not.',
      child: ProseSections(
        sections: [
          (
            'Getting started',
            'Open any flow from the Flows section, pick a subflow, and it runs '
                'live in the device preview. The free flows can be downloaded '
                'and dropped into a Flutter project.',
          ),
          (
            'Something looks broken',
            'Try a hard refresh first. If a preview still misbehaves, send the '
                'flow name and your browser version to the email below.',
          ),
          (
            'Still stuck',
            'Email devesh09269@gmail.com or reach out on X. Replies usually go '
                'out within a couple of days.',
          ),
        ],
      ),
    );
  }
}
