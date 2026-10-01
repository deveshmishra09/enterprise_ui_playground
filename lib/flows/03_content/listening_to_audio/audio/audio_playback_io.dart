import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class AudioPlaybackController {
    final AudioPlayer _player = AudioPlayer()
        ..audioCache = AudioCache(prefix: '');

  Stream<Duration> get onDurationChanged => _player.onDurationChanged;

  Stream<Duration> get onPositionChanged => _player.onPositionChanged;

  Stream<bool> get onPlayingChanged => _player.onPlayerStateChanged
      .map((state) => state == PlayerState.playing);

  Stream<void> get onCompleted => _player.onPlayerComplete;

  Future<void> loadAndPlay(String assetPath) =>
      _player.play(AssetSource(assetPath));

  Future<void> resume() => _player.resume();

  Future<void> pause() => _player.pause();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> dispose() => _player.dispose();
}

AudioPlaybackController createAudioPlaybackController() =>
    AudioPlaybackController();
