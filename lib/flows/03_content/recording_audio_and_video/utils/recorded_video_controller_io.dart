import 'dart:io';

import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

VideoPlayerController createPlatformRecordedVideoController(XFile video) {
  return VideoPlayerController.file(File(video.path));
}
