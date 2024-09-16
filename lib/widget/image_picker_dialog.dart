import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_db/widget/message_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:movie_db/res/label.dart';
import 'package:movie_db/utils/image_utils.dart';
import 'package:movie_db/utils/permission_utils.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function(File)? onPickImage;

  const ImagePickerDialog({
    super.key,
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () async {
                  PermissionUtils.requestPermission(context, Permission.camera, isOpenSettingIfPermanentDenied: true,
                      onPermissionGranted: () {
                        ImageUtils.pickImage(ImageSource.camera, context, onPickedImage: (file) {
                          Get.back();
                          onPickImage?.call(file);
                        });
                      }, onPermissionDenied: () {
                        Get.dialog(MessageDialog(Label.cameraAndPhotosPermissionIsRequired.tr, isError: true));
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.camera_alt,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(Label.takeFromCamera.tr,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 16.0,
                          ))
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  PermissionUtils.requestPermission(context, Platform.isAndroid ? Permission.storage : Permission.photos,
                      isOpenSettingIfPermanentDenied: true, onPermissionGranted: () {
                        ImageUtils.pickImage(ImageSource.gallery, context, onPickedImage: (file) {
                          Get.back();
                          onPickImage?.call(file);
                        });
                      }, onPermissionDenied: () {
                        Get.dialog(MessageDialog(Label.cameraAndPhotosPermissionIsRequired.tr, isError: true,));
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.photo_library,
                        color: Colors.black54,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(Label.chooseFromGallery.tr,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 16.0,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
