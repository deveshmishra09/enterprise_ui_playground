import 'package:flutter/widgets.dart';

import 'tp_local_image_provider_io.dart'
    if (dart.library.html) 'tp_local_image_provider_web.dart'
    as platform;

ImageProvider<Object> localImageProvider(String path) {
  if (path.startsWith('lib/')) {
    return AssetImage(path);
  }

  return platform.localImageProvider(path);
}
