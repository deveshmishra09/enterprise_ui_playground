import 'dart:async';

import 'package:enterprise_ui_playground/flows/03_content/listening_to_audio/constants/song_details.dart';
import 'package:enterprise_ui_playground/flows/03_content/listening_to_audio/audio/audio_playback.dart';
import 'package:flutter/material.dart';

class PlayingSongScreen extends StatefulWidget {
  const PlayingSongScreen({
    required this.songIndex,
    this.autoPlay = true,
    super.key,
  });

  final int songIndex;
  final bool autoPlay;

  @override
  State<PlayingSongScreen> createState() => _PlayingSongScreenState();
}

class _PlayingSongScreenState extends State<PlayingSongScreen> {
  final AudioPlaybackController _player = createAudioPlaybackController();
  late int _currentSongIndex;
  late final StreamSubscription<Duration> _durationSubscription;
  late final StreamSubscription<Duration> _positionSubscription;
  late final StreamSubscription<bool> _playerStateSubscription;
  late final StreamSubscription<void> _completionSubscription;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _sourceLoaded = false;
  String? _playbackError;

  @override
  void initState() {
    super.initState();
    _currentSongIndex = widget.songIndex;
    _durationSubscription = _player.onDurationChanged.listen((duration) {
      if (mounted && duration > Duration.zero) {
        setState(() => _duration = duration);
      }
    });
    _positionSubscription = _player.onPositionChanged.listen((position) {
      if (mounted) setState(() => _position = position);
    });
    _playerStateSubscription = _player.onPlayingChanged.listen((isPlaying) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isPlaying = isPlaying;
        });
      }
    });
    _completionSubscription = _player.onCompleted.listen((_) {
      if (mounted) {
        setState(() {
          _position = _duration;
          _isPlaying = false;
        });
      }
    });
    if (widget.autoPlay) {
      _isLoading = true;
      unawaited(_startPlayback());
    }
  }

  Future<void> _startPlayback() async {
    try {
      if (_sourceLoaded) {
        await _player.resume().timeout(const Duration(seconds: 8));
      } else {
        await _player
            .loadAndPlay(SongDetails.allSongAudioPath[_currentSongIndex])
            .timeout(const Duration(seconds: 8));
      }
      _sourceLoaded = true;
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isPlaying = true;
          _playbackError = null;
        });
      }
    } on Exception catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _playbackError = 'Tap play to start this song';
        });
      }
      debugPrint('Unable to start audio playback: $error');
    }
  }

  Future<void> _togglePlayback() async {
    if (_isLoading) return;

    if (_isPlaying) {
      try {
        await _player.pause();
        if (mounted) setState(() => _isPlaying = false);
      } on Exception catch (error) {
        debugPrint('Unable to pause audio playback: $error');
      }
      return;
    }

    if (mounted) {
      setState(() {
        _isLoading = true;
        _playbackError = null;
      });
    }

    try {
      if (_position >= _duration && _duration > Duration.zero) {
        await _player.seek(Duration.zero);
      }
      await _startPlayback();
    } on Exception catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _playbackError = 'Unable to play this song';
        });
      }
      debugPrint('Unable to toggle audio playback: $error');
    }
  }

  Future<void> _switchSong(int songIndex) async {
    if (_isLoading) return;

    setState(() {
      _currentSongIndex = songIndex;
      _duration = Duration.zero;
      _position = Duration.zero;
      _sourceLoaded = false;
      _isLoading = true;
      _playbackError = null;
    });
    await _startPlayback();
  }

  void _seek(double value) {
    final newPosition = Duration(
      milliseconds: (value * _duration.inMilliseconds).round(),
    );
    setState(() => _position = newPosition);
    unawaited(_player.seek(newPosition));
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    unawaited(_durationSubscription.cancel());
    unawaited(_positionSubscription.cancel());
    unawaited(_playerStateSubscription.cancel());
    unawaited(_completionSubscription.cancel());
    unawaited(_player.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final songIndex = _currentSongIndex;
    final title = SongDetails.allSongTitles[songIndex];
    final artist = SongDetails.allSongArtists[songIndex];
    final poster = SongDetails.allSongImagePath[songIndex];
    final progress = _duration.inMilliseconds == 0
        ? 0.0
        : (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xff17191a),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    color: Colors.white,
                  ),
                  const Spacer(),
                  const Text(
                    'NOW PLAYING',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final posterSize = (constraints.maxHeight * 0.42).clamp(
                    180.0,
                    constraints.maxWidth,
                  );

                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: posterSize,
                              height: posterSize,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  poster,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const ColoredBox(
                                        color: Color(0xff2d3032),
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          color: Colors.white54,
                                          size: 42,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                artist,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.red,
                                inactiveTrackColor: Colors.white24,
                                thumbColor: Colors.red,
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 5,
                                ),
                              ),
                              child: Slider(
                                value: progress,
                                onChanged: _duration == Duration.zero
                                    ? null
                                    : _seek,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDuration(_position),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  _formatDuration(_duration),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            if (_playbackError != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                _playbackError!,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: _currentSongIndex > 0
                                      ? () => unawaited(
                                          _switchSong(_currentSongIndex - 1),
                                        )
                                      : null,
                                  icon: const Icon(Icons.skip_previous),
                                  color: Colors.white70,
                                  iconSize: 32,
                                ),
                                IconButton(
                                  onPressed: () {
                                    unawaited(_togglePlayback());
                                  },
                                  icon: Icon(
                                    _isLoading
                                        ? Icons.hourglass_top
                                        : _isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  color: Colors.black,
                                  iconSize: 34,
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    minimumSize: const Size(64, 64),
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      _currentSongIndex <
                                          SongDetails.allSongTitles.length - 1
                                      ? () => unawaited(
                                          _switchSong(_currentSongIndex + 1),
                                        )
                                      : null,
                                  icon: const Icon(Icons.skip_next),
                                  color: Colors.white70,
                                  iconSize: 32,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
