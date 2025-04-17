import 'package:flutter/material.dart';
import 'package:front/core/theme/test_style_preset.dart';
import 'package:front/core/utils/widget_image_saver.dart';
import 'package:screenshot/screenshot.dart';

class CaptureAndShareWidget extends StatelessWidget {

  final Widget body;

  const CaptureAndShareWidget({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(right: 20, top: 10),
            child: Column(
              children: [
                IconButton(
                    onPressed: () => WidgetImageSaver.captureAndShareScreenshot(),
                    icon: const Icon(Icons.share)
                ),
                const Text("이미지로 공유", style: TextStylePreset.thumbnailSubtitle,)
              ],
            ),
          ),
        ),
        Screenshot(
            controller: WidgetImageSaver.controller,
            child: body
        ),
      ]
    );
  }
}