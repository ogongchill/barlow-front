import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class WidgetImageSaver {

  static final _screenshotController = ScreenshotController();

  static Future<void> captureAndShareScreenshot() async {
    try {
      final image = await _screenshotController.capture(pixelRatio: 3.0);
      if (image == null) return;

      // 임시 저장 디렉토리 경로
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/shared_screenshot.png';

      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);

      // 공유 시트 열기
      await Share.shareXFiles([XFile(imagePath)], text: '공유하기');
    } catch (e) {
      debugPrint('스크린샷 공유 실패: $e');
    }
  }

  static ScreenshotController get controller => _screenshotController;
}
