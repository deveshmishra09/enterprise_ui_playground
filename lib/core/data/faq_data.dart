import 'package:enterprise_ui_playground/core/models/faq_item.dart';

// TODO(copy): draft answers — review and finalize before launch (decision R4).
const List<FaqItem> kFaqItems = <FaqItem>[
  FaqItem(
    question: 'What is Enterprise UI Playground?',
    answer:
        'A library of mobile UI flows you can preview live in the browser, '
        'customize, and download — every one built with Flutter.',
  ),
  FaqItem(
    question: 'Are the flows really free?',
    answer:
        'The flows marked free can be downloaded at no cost. Plus unlocks the '
        'full set with source for every subflow.',
  ),
  FaqItem(
    question: 'Can I use these in commercial apps?',
    answer:
        'Yes. The free flows can be used in personal and commercial projects; '
        'see the Terms page for the full license.',
  ),
  FaqItem(
    question: "What's included in Plus?",
    answer:
        'Every one of the 71 subflows, full source for each, new flows as they '
        'land, and a commercial license.',
  ),
  FaqItem(
    question: 'Is the whole site built with Flutter?',
    answer:
        'It is — the site and every subflow demo are one Flutter codebase '
        'running as a responsive web app.',
  ),
];
