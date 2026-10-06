import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

import '../utils/recorded_video_controller.dart';

class RecordingAudioAndVideo extends StatefulWidget {
  const RecordingAudioAndVideo({super.key});

  @override
  State<RecordingAudioAndVideo> createState() => _RecordingAudioAndVideoState();
}

class _RecordingAudioAndVideoState extends State<RecordingAudioAndVideo>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription> _availableCameras = [];
  bool _isCameraInitialized = false;
  bool _isRecording = false;
  int _selectedCameraIndex = 0; // 0 for rear, 1 for front (usually)
  String? _cameraError;
  final List<XFile> _recordedVideos = [];
  XFile? _selectedVideo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupCameras();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  // Safely manage app lifecycle states (e.g. app goes to background)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (state == AppLifecycleState.inactive) {
      if (cameraController == null || !cameraController.value.isInitialized) {
        return;
      }
      if (mounted) {
        setState(() {
          _isCameraInitialized = false;
        });
      }
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController == null) return;
      _initCameraController(cameraController.description);
    }
  }

  // 1. Fetch available physical cameras on the device
  Future<void> _setupCameras() async {
    if (mounted) {
      setState(() {
        _cameraError = null;
        _isCameraInitialized = false;
      });
    }

    try {
      _availableCameras = await availableCameras();
      if (_availableCameras.isEmpty) {
        _setCameraError('No camera was found on this device.');
        return;
      }

      if (_selectedCameraIndex >= _availableCameras.length) {
        _selectedCameraIndex = _availableCameras.length - 1;
      }
      await _initCameraController(_availableCameras[_selectedCameraIndex]);
    } catch (e) {
      debugPrint('Error fetching cameras: $e');
      debugPrintStack(stackTrace: StackTrace.current);
      _setCameraError(_cameraErrorMessage(e));
    }
  }

  // 2. Initialize the specific camera controller with audio enabled
  Future<void> _initCameraController(
    CameraDescription cameraDescription,
  ) async {
    // Clean up old controller if it exists
    await _cameraController?.dispose();

    final controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: true, // Captures microphone audio simultaneously with video
    );
    _cameraController = controller;
    if (mounted) {
      setState(() {
        _isCameraInitialized = false;
        _cameraError = null;
      });
    }

    try {
      await controller.initialize();
      if (mounted && identical(_cameraController, controller)) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing camera controller: $e');
      await controller.dispose();
      if (mounted && identical(_cameraController, controller)) {
        _cameraController = null;
        _setCameraError(_cameraErrorMessage(e));
      }
    }
  }

  String _cameraErrorMessage(Object error) {
    if (error is CameraException) {
      switch (error.code) {
        case 'CameraAccessDenied':
        case 'CameraAccessDeniedWithoutPrompt':
        case 'CameraAccessRestricted':
          return 'Camera access was blocked by the device. Confirm that this app has camera access in system settings, then try again.';
        case 'AudioAccessDenied':
        case 'AudioAccessDeniedWithoutPrompt':
        case 'AudioAccessRestricted':
          return 'Microphone access is required to record audio. Confirm that this app has microphone access in system settings, then try again.';
        case 'CameraDisconnected':
          return 'The camera was disconnected. Reconnect it and try again.';
        default:
          return _unknownCameraError(error.code, error.description);
      }
    }

    return _unknownCameraError(error.runtimeType.toString(), error.toString());
  }

  String _unknownCameraError(String code, String? description) {
    final details = description == null || description.isEmpty
        ? code
        : '$code: $description';
    return 'The camera could not be started. It may be in use by another app or unavailable on this device.\n\nDetails: $details';
  }

  void _setCameraError(String message) {
    if (!mounted) return;
    setState(() {
      _isCameraInitialized = false;
      _cameraError = message;
    });
  }

  // 3. Handle start / stop recording toggle logic
  Future<void> _toggleVideoRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

    if (_isRecording) {
      // Stop recording
      try {
        final recordedVideo = await _cameraController!.stopVideoRecording();
        if (!mounted) return;
        setState(() {
          _isRecording = false;
          _recordedVideos.insert(0, recordedVideo);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Video saved to your gallery (${_recordedVideos.length} saved)',
            ),
            action: SnackBarAction(label: 'VIEW', onPressed: _showGallery),
          ),
        );
      } catch (e) {
        debugPrint('Error stopping video recording: $e');
      }
    } else {
      // Start recording
      try {
        await _cameraController!.startVideoRecording();
        setState(() {
          _isRecording = true;
        });
      } catch (e) {
        debugPrint('Error starting video recording: $e');
      }
    }
  }

  // 4. Switch between front and back cameras dynamically
  Future<void> _switchCamera() async {
    if (_availableCameras.length < 2 || _isRecording) return;

    setState(() {
      _isCameraInitialized = false;
      _selectedCameraIndex =
          (_selectedCameraIndex + 1) % _availableCameras.length;
    });

    await _initCameraController(_availableCameras[_selectedCameraIndex]);
  }

  void _showGallery() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.grey.shade900,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 12, 12),
                  child: Row(
                    children: [
                      Icon(Icons.video_library, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Recorded videos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white24, height: 1),
                Expanded(
                  child: _recordedVideos.isEmpty
                      ? const Center(
                          child: Text(
                            'Your recorded videos will appear here.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: _recordedVideos.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final video = _recordedVideos[index];
                            return ListTile(
                              tileColor: Colors.white10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.white24,
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  _selectedVideo = video;
                                });
                              },
                              title: Text(
                                'Video ${_recordedVideos.length - index}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                video.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white60),
                              ),
                              trailing: IconButton(
                                tooltip: 'Remove from gallery',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white70,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _recordedVideos.removeAt(index);
                                  });
                                  if (_recordedVideos.isEmpty &&
                                      Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraError != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.no_photography_outlined,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  _cameraError!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: _setupCameras,
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Audio & Video Recorder'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Native camera preview layer
          CameraPreview(_cameraController!),

          // Overlay recording status indicator
          if (_isRecording)
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(200),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.fiber_manual_record,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'REC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          if (_selectedVideo != null)
            LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 700;
                return Positioned(
                  left: isCompact ? 12 : null,
                  right: 12,
                  // Keep the playback card above the recorder controls.
                  bottom: isCompact ? 132 : null,
                  top: isCompact ? null : 12,
                  width: isCompact
                      ? null
                      : (constraints.maxWidth * 0.4)
                            .clamp(320.0, 460.0)
                            .toDouble(),
                  height: isCompact
                      ? constraints.maxHeight * 0.42
                      : constraints.maxHeight - 24,
                  child: _RecordedVideoPlayer(
                    video: _selectedVideo!,
                    onClose: () {
                      setState(() {
                        _selectedVideo = null;
                      });
                    },
                  ),
                );
              },
            ),

          // Lower control deck interface
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Camera Toggle Button
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _isRecording ? null : _switchCamera,
                ),

                // Primary Record Trigger Button
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Semantics(
                    button: true,
                    label: _isRecording
                        ? 'Stop audio and video recording'
                        : 'Start audio and video recording',
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _isRecording ? Colors.red : Colors.white,
                          borderRadius: BorderRadius.circular(
                            _isRecording ? 8 : 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: _toggleVideoRecording,
                ),

                IconButton(
                  tooltip: 'Open recorded videos',
                  icon: Badge(
                    isLabelVisible: _recordedVideos.isNotEmpty,
                    label: Text('${_recordedVideos.length}'),
                    child: const Icon(
                      Icons.video_library_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onPressed: _showGallery,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordedVideoPlayer extends StatefulWidget {
  const _RecordedVideoPlayer({required this.video, required this.onClose});

  final XFile video;
  final VoidCallback onClose;

  @override
  State<_RecordedVideoPlayer> createState() => _RecordedVideoPlayerState();
}

class _RecordedVideoPlayerState extends State<_RecordedVideoPlayer> {
  VideoPlayerController? _controller;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final controller = createRecordedVideoController(widget.video);
    _controller = controller;

    try {
      await controller.initialize();
      if (!mounted) return;
      setState(() {});
      await controller.play();
    } catch (error) {
      await controller.dispose();
      if (!mounted) return;
      setState(() {
        _error = error;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Material(
      color: Colors.black87,
      elevation: 12,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: controller == null
          ? const SizedBox(
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          : _error != null
          ? _VideoPlaybackError(error: _error!, onClose: widget.onClose)
          : ValueListenableBuilder<VideoPlayerValue>(
              valueListenable: controller,
              builder: (context, value, child) {
                if (!value.isInitialized) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }

                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: value.aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ),
                    VideoProgressIndicator(
                      controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      colors: const VideoProgressColors(
                        playedColor: Colors.red,
                        bufferedColor: Colors.white38,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: value.isPlaying ? 'Pause' : 'Play',
                          color: Colors.white,
                          icon: Icon(
                            value.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                          onPressed: () {
                            value.isPlaying
                                ? controller.pause()
                                : controller.play();
                          },
                        ),
                        Expanded(
                          child: Text(
                            widget.video.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Close player',
                          color: Colors.white,
                          icon: const Icon(Icons.close),
                          onPressed: widget.onClose,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class _VideoPlaybackError extends StatelessWidget {
  const _VideoPlaybackError({required this.error, required this.onClose});

  final Object error;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 40),
          const SizedBox(height: 12),
          const Text(
            'This recording could not be played.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 16),
          TextButton(onPressed: onClose, child: const Text('Close')),
        ],
      ),
    );
  }
}
