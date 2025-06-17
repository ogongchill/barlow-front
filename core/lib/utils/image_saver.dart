import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class ImageSaver {

  static Future<String> saveTemporary(Uint8List image) async {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/shared_screenshot.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(image);
    return imagePath;
  }
}