import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Show {
  static var _loadDialog;

  static showLoading({bool barrierDismissible = false}) {
    _loadDialog ??= _showLoadingDialog(barrierDismissible: barrierDismissible);
  }

  static stopLoading() {
    if (_loadDialog != null) {
      Get.back();
      _loadDialog = null;
    }
  }

  static Future _showLoadingDialog({bool barrierDismissible = false}) {
    return Get.dialog(
        PopScope(
          canPop: barrierDismissible,
          onPopInvoked: (pop) {
            if (pop) {
              _loadDialog = null;
            }
          },
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        )
    );
  }
}