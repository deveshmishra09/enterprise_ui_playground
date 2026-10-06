import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

import 'recorded_video_controller_io.dart'
    if (dart.library.html) 'recorded_video_controller_web.dart';

VideoPlayerController createRecordedVideoController(XFile video) {
  return createPlatformRecordedVideoController(video);
}
