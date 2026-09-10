import 'package:flutter/material.dart';

import 'package:enterprise_ui_playground/core/widgets/info_page_scaffold.dart';
import 'package:enterprise_ui_playground/core/widgets/prose_sections.dart';

/// Route `/terms`. Structure modelled on withanimation.app/terms.
// TODO(copy): draft terms — replace with reviewed legal text before launch (R4).
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPageScaffold(
      eyebrow: 'TERMS',
      title: 'Terms of use',
      intro: 'The ground rules for using the flows and this site. '
          'Last updated: TODO.',
      child: ProseSections(
        sections: [
          (
            'Using the flows',
            'The flows are provided as reference implementations. You are free '
                'to run them in the browser and study how they work.',
          ),
          (
            'License',
            'Free flows may be used in personal and commercial projects. Plus '
                'flows are covered by the Plus license. Redistributing the flow '
                'library as-is is not permitted.',
          ),
          (
            'No warranty',
            'The flows and site are provided "as is", without warranty of any '
                'kind. Use in production is at your own discretion.',
          ),
          (
            'Changes',
            'These terms may change as the project grows; the latest version '
                'always lives on this page.',
          ),
        ],
      ),
    );
  }
}
