import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:movie_db/res/label.dart';
import 'package:movie_db/utils/toast_utils.dart';

class ShareUtils {

  static Future<void> share(String text, {String? subject}) async {
    await Share.share(text, subject: subject);
  }

  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ToastUtils.show(message: Label.copiedToClipboard.tr);
  }
}