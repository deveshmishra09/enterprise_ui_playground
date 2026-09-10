import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/widgets/info_page_scaffold.dart';
import 'package:enterprise_ui_playground/core/widgets/prose_sections.dart';

/// Route `/privacy`. Structure modelled on withanimation.app/privacy.
// TODO(copy): draft privacy content — review with a human before launch (R4).
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPageScaffold(
      eyebrow: 'PRIVACY',
      title: 'Privacy policy',
      intro:
          'A short summary of what this site collects and what it does not. '
          'Last updated: TODO.',
      child: ProseSections(
        sections: [
          (
            'What we collect',
            'The site is a static web app. It does not require an account and '
                'does not ask for personal information. Basic, aggregated '
                'analytics may be used to understand which flows are popular.',
          ),
          (
            'What we do not do',
            'No selling of data, no advertising trackers, no cross-site '
                'profiles. The device preview runs entirely in your browser.',
          ),
          (
            'Your choices',
            'You can block analytics with any standard content blocker without '
                'affecting how the flows work.',
          ),
          (
            'Contact',
            'Questions about privacy can go to devesh09269@gmail.com.',
          ),
        ],
      ),
    );
  }
}
