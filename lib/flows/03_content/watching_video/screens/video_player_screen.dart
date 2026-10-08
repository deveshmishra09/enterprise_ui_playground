import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<String> videoPaths;

  const VideoPlayerScreen({super.key, required this.videoPaths});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _initializeVideoPlayerFuture = _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    for (final path in widget.videoPaths) {
      _controller = VideoPlayerController.asset(path);
      _controller.setLooping(true);

      try {
        await _controller.initialize().timeout(const Duration(seconds: 30));
        await _controller.play();
        if (mounted) {
          setState(() {});
        }
        return; // Success, exit the function
      } catch (error, stackTrace) {
        debugPrint('Video initialization failed for $path: $error');
        // If this is the last path, rethrow the error after trying all
        if (path == widget.videoPaths.last) {
          debugPrintStack(stackTrace: stackTrace);
          await _controller.dispose();
          rethrow;
        }
        // Otherwise, try the next path
        await _controller.dispose();
      }
    }
  }

  @override
  void dispose() {
    // 3. CRITICAL: Always dispose the controller to clear memory and prevent leaks!
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Dark background looks best for media players
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
            ),
          ),
          Spacer(),
          FutureBuilder<void>(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return _VideoError(
                  error: snapshot.error!,
                  onRetry: () {
                    setState(() {
                      _initializeVideoPlayerFuture = _initializeVideo();
                    });
                  },
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // 4. Video is ready, display it within its native aspect ratio
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(_controller),
                            // Overlay video progress indicator timeline bar
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing:
                                  true, // Lets user drag timeline to rewind/fast-forward
                              colors: const VideoProgressColors(
                                playedColor: Colors.red,
                                bufferedColor: Colors.grey,
                                backgroundColor: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
          ),
          Spacer(),
        ],
      ),
      // Floating Play / Pause Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            // Toggle play/pause state dynamically
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

class _VideoError extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const _VideoError({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 48),
            const SizedBox(height: 16),
            const Text(
              'This video could not be played on this tablet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
