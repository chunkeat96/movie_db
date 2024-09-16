import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  static pickImage(ImageSource source, BuildContext context, {Function(File)? onPickedImage, bool uniqueFileName = false}) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: source);

      if (null != image) {
        final filePath = image.path;
        final dir = await path_provider.getTemporaryDirectory();
        final fileName = uniqueFileName ? DateTime.now().millisecondsSinceEpoch.toString() : 'temp';
        final targetPath = '${dir.absolute.path}/$fileName.jpg';
        final targetFile = File(targetPath);

        if (await targetFile.exists()) {
          imageCache.clear();
          imageCache.clearLiveImages();
        }

        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          filePath,
          targetPath,
          quality: 50,
        );

        if (compressedFile != null) {
          onPickedImage?.call(File(compressedFile.path));
        }
      }
    } catch (e) {
      if (e is PlatformException) {
        Get.rawSnackbar(message: e.message);
      }
    }
  }
}
