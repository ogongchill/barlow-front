import 'package:core/utils/image_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class WidgetImageSaver {

  static final _screenshotController = ScreenshotController();

  static Future<void> captureAndShareScreenshot() async {
    try {
      final image = await _screenshotController.capture(pixelRatio: 3.0);
      if (image == null) return;
      String imagePath = await ImageSaver.saveTemporary(image);
      await Share.shareXFiles([XFile(imagePath)], text: '공유하기');
    } catch (e) {
      debugPrint('스크린샷 공유 실패: $e');
    }
  }

  static ScreenshotController get controller => _screenshotController;
}
