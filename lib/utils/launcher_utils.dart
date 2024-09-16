import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {

  static Future<bool> launchURL(String url) async {
    if (await canLaunchUrl(Uri(path: url))) {
      await launchUrl(Uri(path: url));
      return true;
    } else {
      return false;
    }
  }
}