import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/widget/load_image.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
      {super.key,
      final String? title,
      final String? subTitle,
      bool super.centerTitle = true,
      final bool showBack = true,
      super.elevation,
      final VoidCallback? onBack,
      super.actions,
      final String leadingIcon = 'arrowleft2',
      double super.leadingWidth = kToolbarHeight,
      super.backgroundColor})
      : super(
            title: Column(
              children: [
                Text(title ?? ''),
                Visibility(
                  visible: subTitle?.isNotEmpty == true,
                  child: Text(subTitle ?? '',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                  )),
                )
              ],
            ),
            leading: showBack
                ? InkWell(
                    onTap: onBack ?? () => Get.back(),
                    child: LoadAssetImage(
                      leadingIcon,
                      width: 24.0,
                      height: 24.0,
                    ))
                : null);
}
