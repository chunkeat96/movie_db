import 'package:package_info_plus/package_info_plus.dart';

class PackageDetails {
  PackageInfo? _packageInfo;
  String? _version;
  String? _buildNumber;

  Future<PackageInfo> get packageInfo async {
    _packageInfo ??= await PackageInfo.fromPlatform();
    return _packageInfo!;
  }

  Future<String> get versionName async {
    _version ??= (await packageInfo).version;
    return _version!;
  }

  Future<String> get buildNumber async {
    _buildNumber ??= (await packageInfo).buildNumber;
    return _buildNumber!;
  }

  Future <String> get versionAndBuildNumber async {
    return "v ${ await versionName} b ${ await buildNumber}";
  }

}
