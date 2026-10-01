import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

class AudioPlaybackController {
  final StreamController<Duration> _durationController =
      StreamController<Duration>.broadcast();
  final StreamController<Duration> _positionController =
      StreamController<Duration>.broadcast();
  final StreamController<bool> _playingController =
      StreamController<bool>.broadcast();
  final StreamController<void> _completedController =
      StreamController<void>.broadcast();
  final List<StreamSubscription<Object?>> _subscriptions = [];

  web.HTMLAudioElement? _audio;

  Stream<Duration> get onDurationChanged => _durationController.stream;

  Stream<Duration> get onPositionChanged => _positionController.stream;

  Stream<bool> get onPlayingChanged => _playingController.stream;

  Stream<void> get onCompleted => _completedController.stream;

  Future<void> loadAndPlay(String assetPath) async {
    await _releaseAudio();

    final audio = web.HTMLAudioElement()
      ..preload = 'auto'
      ..src = Uri.base.replace(path: '/assets/$assetPath').toString();
    _audio = audio;

    _subscriptions.add(
      audio.onLoadedMetadata.listen((_) {
        final seconds = audio.duration;
        if (seconds.isFinite && seconds > 0) {
          _durationController.add(_durationFromSeconds(seconds));
        }
      }),
    );
    _subscriptions.add(
      audio.onTimeUpdate.listen((_) {
        _positionController.add(_durationFromSeconds(audio.currentTime));
      }),
    );
    _subscriptions.add(audio.onPlay.listen((_) => _playingController.add(true)));
    _subscriptions.add(
      audio.onPause.listen((_) => _playingController.add(false)),
    );
    _subscriptions.add(
      audio.onEnded.listen((_) {
        _playingController.add(false);
        _completedController.add(null);
      }),
    );
    audio.load();
    await audio.play().toDart;
  }

  Future<void> resume() async {
    final audio = _audio;
    if (audio == null) return;
    await audio.play().toDart;
  }

  Future<void> pause() async {
    _audio?.pause();
  }

  Future<void> seek(Duration position) async {
    final audio = _audio;
    if (audio == null) return;
    audio.currentTime = position.inMilliseconds / 1000;
  }

  Future<void> _releaseAudio() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    _audio?.pause();
    _audio?.src = '';
    _audio?.remove();
    _audio = null;
  }

  Duration _durationFromSeconds(double seconds) =>
      Duration(microseconds: (seconds * Duration.microsecondsPerSecond).round());

  Future<void> dispose() async {
    await _releaseAudio();
    await _durationController.close();
    await _positionController.close();
    await _playingController.close();
    await _completedController.close();
  }
}

AudioPlaybackController createAudioPlaybackController() =>
    AudioPlaybackController();
