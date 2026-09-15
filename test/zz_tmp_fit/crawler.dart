// THROWAWAY: fit-issue crawler for built subflows. Delete after use.
// ignore_for_file: avoid_print
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:enterprise_ui_playground/core/data/flows_data.dart';
import 'package:enterprise_ui_playground/core/models/sub_flow.dart';
import 'package:enterprise_ui_playground/core/widgets/device_frame_preview.dart';

const _fallbackFontDir =
    'D:/Development/flutter/bin/cache/artifacts/material_fonts';
const _maxDepth = 10;
const _shotDir =
    'C:/Users/Devesh/AppData/Local/Temp/claude/D--flutter-enterprise-ui-playground/5fb8586c-2352-4e59-916f-8a06b13ed55d/scratchpad/shots';
final _shotKey = GlobalKey();

Size _windowFor(ScreenView view) => switch (view) {
  ScreenView.mobile => const Size(460, 960),
  ScreenView.tablet => const Size(780, 1030),
  ScreenView.web => const Size(1460, 960),
};
const _maxStates = 80;
const _maxCandidates = 40;
const _fill = -1;

Future<void> _loadFonts() async {
  final flutterRoot = Platform.environment['FLUTTER_ROOT'];
  final fontDirCandidates = <String>[
    if (flutterRoot != null && flutterRoot.isNotEmpty)
      '$flutterRoot/bin/cache/artifacts/material_fonts',
    _fallbackFontDir,
  ];
  final fontDir = fontDirCandidates.firstWhere(
    (dir) => Directory(dir).existsSync(),
    orElse: () => '',
  );
  if (fontDir.isEmpty) return;

  ByteData read(String f) =>
      ByteData.sublistView(File('$fontDir/$f').readAsBytesSync());
  const roboto = [
    'roboto-regular.ttf',
    'roboto-medium.ttf',
    'roboto-bold.ttf',
    'roboto-light.ttf',
    'roboto-black.ttf',
    'roboto-thin.ttf',
    'roboto-italic.ttf',
    'roboto-bolditalic.ttf',
    'roboto-mediumitalic.ttf',
  ];
  for (final family in ['Roboto', 'Segoe UI', 'FlutterTest']) {
    final loader = FontLoader(family);
    for (final f in roboto) {
      loader.addFont(Future.value(read(f)));
    }
    await loader.load();
  }
  final icons = FontLoader('MaterialIcons')
    ..addFont(Future.value(read('materialicons-regular.otf')));
  await icons.load();
}

void crawlBuiltSubflow(int builtIndex, {List<ScreenView>? views}) {
  final built = <SubFlow>[
    for (final f in kAllFlows)
      for (final s in f.subFlows)
        if (s.isBuilt) s,
  ];
  final sub = built[builtIndex];
  GoogleFonts.config.allowRuntimeFetching = false;
  if (Platform.environment['NO_FONTS'] == null) setUpAll(_loadFonts);
  for (final view in views ?? ScreenView.values) {
    testWidgets(
      '${sub.slug} ${view.name}',
      (tester) => _crawl(tester, sub, view),
      variant: TargetPlatformVariant({TargetPlatform.windows, TargetPlatform.android}),
      timeout: const Timeout(Duration(minutes: 40)),
    );
  }
}

typedef _Step = ({int index, String label});

final _dfp = find.byType(DeviceFramePreview);

Future<void> _crawl(WidgetTester tester, SubFlow sub, ScreenView view) async {
  tester.view.physicalSize = _windowFor(view);
  final shotScreens = <String>{};
  var shotCount = 0;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  final errors = <FlutterErrorDetails>[];
  final original = FlutterError.onError;
  FlutterError.onError = errors.add;
  final reported = <String>{};
  final seenStates = <String>{};
  final queue = <List<_Step>>[<_Step>[]];
  var replays = 0;
  final sw = Stopwatch()..start();

  void flush(List<_Step> path) {
    for (final d in errors) {
      final full = d.toString();
      final first = d.exceptionAsString().split('\n').first.trim();
      final locs = RegExp(r'file:///[^\s)]+?\.dart:\d+:\d+')
          .allMatches(full)
          .map((m) => m.group(0)!)
          .toList();
      final rawLoc = locs.firstWhere(
        (l) => l.contains('/lib/flows/'),
        orElse: () => locs.isEmpty ? '?' : locs.first,
      );
      final loc = rawLoc.replaceAll(RegExp(r'^.*?/lib/'), 'lib/');
      final isLayout = RegExp(
        r'overflowed|infinite|unbounded|not laid out|constraints|RenderBox',
      ).hasMatch(first);
      final kind = isLayout ? 'LAYOUT' : 'OTHER';
      final dir =
          RegExp(r'on the (right|left|bottom|top)').firstMatch(first)?.group(0) ??
          '';
      final key = '$kind|$loc|$dir|${isLayout ? '' : first}';
      if (!reported.add(key)) continue;
      final screens = _screens(tester).join(' > ');
      final pathText = path.map((s) => s.label).join(' -> ');
      print(
        'FIND\t${defaultTargetPlatform.name}\t${sub.slug}\t${view.name}\t$kind\t$first\t$loc\t[$screens]\t'
        '{${pathText.isEmpty ? '(start)' : pathText}}',
      );
    }
    errors.clear();
  }

  try {
    while (queue.isNotEmpty && seenStates.length < _maxStates) {
      final path = queue.removeAt(0);
      replays++;
      final ok = await _replay(tester, sub, view, path);
      flush(path);
      if (!ok) continue;
      final sig = _signature(tester);
      if (!seenStates.add(sig)) continue;
      await _precacheImages(tester);
      await _scrollAll(tester);
      flush(path);
      final screensKey = _screens(tester)
          .where((n) => n != 'DisplayFeatureSubScreen' && n != 'BottomSheet')
          .join('+');
      if (defaultTargetPlatform == TargetPlatform.windows &&
          shotScreens.add(screensKey)) {
        shotCount++;
        await _capturePages(
          tester,
          '$_shotDir/${sub.slug}/${view.name}/'
          '${shotCount.toString().padLeft(2, '0')}_${screensKey.isEmpty ? 'EMPTY' : screensKey}',
        );
        flush(path);
      }
      if (path.length >= _maxDepth) continue;

      if (_emptyFields(tester).isNotEmpty) {
        queue.add([...path, (index: _fill, label: '(fill fields)')]);
      }
      final seenLabels = <String, int>{};
      final cands = _candidates(tester);
      print(
        'STATE\t${defaultTargetPlatform.name}\t${sub.slug}\t${view.name}\t[${_screens(tester).join(' > ')}]\t'
        'depth=${path.length}\tcands=${cands.map(_label).toSet().join(' | ')}',
      );
      var added = 0;
      for (var i = 0; i < cands.length && added < _maxCandidates; i++) {
        final label = _label(cands[i]);
        final seen = seenLabels[label] = (seenLabels[label] ?? 0) + 1;
        if (seen > 3) continue;
        queue.add([...path, (index: i, label: label)]);
        added++;
      }
    }
  } finally {
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 10));
    flush(const []);
    FlutterError.onError = original;
  }
  print(
    'DONE\t${defaultTargetPlatform.name}\t${sub.slug}\t${view.name}\tstates=${seenStates.length}\t'
    'replays=$replays\tqueueLeft=${queue.length}\t${sw.elapsed.inSeconds}s',
  );
}

Future<bool> _replay(
  WidgetTester tester,
  SubFlow sub,
  ScreenView view,
  List<_Step> path,
) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 10));
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RepaintBoundary(
          key: _shotKey,
          child: DeviceFramePreview(
            screenView: view,
            child: Builder(builder: sub.screenBuilder!),
          ),
        ),
      ),
    ),
  );
  await _settle(tester);
  for (final step in path) {
    if (step.index == _fill) {
      await _fillFields(tester);
    } else {
      final cands = _candidates(tester);
      if (step.index >= cands.length) return false;
      final box = cands[step.index].renderObject! as RenderBox;
      await tester.tapAt(box.localToGlobal(box.size.center(Offset.zero)));
    }
    await _settle(tester);
  }
  return true;
}

Future<void> _settle(WidgetTester tester) async {
  for (final ms in const [0, 100, 250, 400, 800, 1000, 1500]) {
    await tester.pump(Duration(milliseconds: ms));
  }
}

List<Element> _candidates(WidgetTester tester) => find
    .descendant(
      of: _dfp,
      matching: find.byWidgetPredicate(
        (w) =>
            (w is InkResponse && (w.onTap != null || w.onTapDown != null)) ||
            (w is GestureDetector && w.onTap != null),
      ),
    )
    .hitTestable()
    .evaluate()
    .toList();

List<Element> _emptyFields(WidgetTester tester) => find
    .descendant(of: _dfp, matching: find.byType(EditableText))
    .hitTestable()
    .evaluate()
    .where((e) {
      final w = e.widget as EditableText;
      return !w.readOnly && w.controller.text.isEmpty;
    })
    .toList();

Future<void> _fillFields(WidgetTester tester) async {
  for (final e in _emptyFields(tester)) {
    final w = e.widget as EditableText;
    final kb = w.keyboardType;
    final text = (kb == TextInputType.number || kb == TextInputType.phone)
        ? '1234567890'
        : kb == TextInputType.emailAddress
        ? 'test@example.com'
        : 'Test1234!';
    await tester.enterText(
      find.byElementPredicate((x) => identical(x, e)),
      text,
    );
    await tester.pump();
  }
}

String _label(Element e) {
  String? found;
  void visit(Element c) {
    if (found != null) return;
    final w = c.widget;
    if (w is Text) {
      found = w.data ?? w.textSpan?.toPlainText();
    } else if (w is RichText) {
      found = w.text.toPlainText();
    } else if (w is Icon) {
      found = 'icon:${w.icon?.codePoint.toRadixString(16)}';
    } else if (w is Tooltip) {
      found = 'tip:${w.message}';
    } else {
      c.visitChildren(visit);
    }
  }

  visit(e);
  final label = (found ?? e.widget.runtimeType.toString())
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  return label.length > 40 ? '${label.substring(0, 40)}...' : label;
}

final _screenName = RegExp(r'(Screen|Sheet|Dialog|Page)$');

List<String> _screens(WidgetTester tester) {
  final names = <String>[];
  for (final e in find
      .descendant(
        of: _dfp,
        matching: find.byWidgetPredicate((w) {
          final n = w.runtimeType.toString();
          return _screenName.hasMatch(n) && !n.startsWith('_');
        }),
      )
      .evaluate()) {
    final n = e.widget.runtimeType.toString();
    if (names.isEmpty || names.last != n) names.add(n);
  }
  return names;
}

String _signature(WidgetTester tester) {
  final texts = find
      .descendant(of: _dfp, matching: find.byType(Text))
      .hitTestable()
      .evaluate()
      .map((e) {
        final t = e.widget as Text;
        return t.data ?? t.textSpan?.toPlainText() ?? '';
      });
  final cands = _candidates(tester).map(_label).join('|');
  return '${_screens(tester).join('>')}|${texts.join('|')}|$cands';
}

Future<void> _capturePages(WidgetTester tester, String basePath) async {
  // Page through the largest vertical scrollable so below-the-fold content
  // is reviewed too.
  ScrollableState? main;
  var mainExtent = 0.0;
  for (final e in find
      .descendant(of: _dfp, matching: find.byType(Scrollable))
      .hitTestable()
      .evaluate()) {
    final s = (e as StatefulElement).state as ScrollableState;
    if (s.axisDirection != AxisDirection.down) continue;
    try {
      if (s.position.hasContentDimensions &&
          s.position.viewportDimension > mainExtent) {
        main = s;
        mainExtent = s.position.viewportDimension;
      }
    } catch (_) {}
  }

  Future<void> shoot(int page) async {
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(_shotKey),
    );
    await tester.runAsync(() async {
      final image = await boundary.toImage();
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      final file = File('${basePath}_p$page.png');
      file.parent.createSync(recursive: true);
      file.writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  await shoot(0);
  final pos = main?.position;
  if (pos == null) return;
  for (var page = 1; page < 6 && pos.pixels < pos.maxScrollExtent; page++) {
    pos.jumpTo(
      math.min(pos.pixels + pos.viewportDimension * 0.85, pos.maxScrollExtent),
    );
    await tester.pump();
    await shoot(page);
  }
  pos.jumpTo(pos.minScrollExtent);
  await tester.pump();
}

Future<void> _precacheImages(WidgetTester tester) async {
  final images = find
      .descendant(of: _dfp, matching: find.byType(Image))
      .evaluate()
      .toList();
  if (images.isEmpty) return;
  await tester.runAsync(() async {
    for (final e in images) {
      try {
        await precacheImage((e.widget as Image).image, e);
      } catch (_) {}
    }
  });
  await tester.pump();
}

Future<void> _scrollAll(WidgetTester tester) async {
  final states = find
      .descendant(of: _dfp, matching: find.byType(Scrollable))
      .evaluate()
      .map((e) => (e as StatefulElement).state as ScrollableState)
      .toList();
  for (final s in states) {
    try {
      final pos = s.position;
      if (!pos.hasContentDimensions) continue;
      var guard = 0;
      while (pos.pixels < pos.maxScrollExtent && guard++ < 60) {
        pos.jumpTo(
          math.min(
            pos.pixels + pos.viewportDimension * 0.8,
            pos.maxScrollExtent,
          ),
        );
        await tester.pump();
      }
      pos.jumpTo(pos.minScrollExtent);
      await tester.pump();
    } catch (_) {}
  }
}
