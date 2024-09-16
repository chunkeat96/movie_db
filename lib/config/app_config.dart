import 'package:movie_db/global/define.dart';

import 'config.dart';

enum Env {
  dev,
  prod
}

class AppConfig {
  late Config config;

  String get appName => Define.appName;
  Env get env => Env.values.firstWhere((element) => element.toString() == "Env.${Define.appEnv}", orElse: () => Env.prod);

  AppConfig() {
    switch(env) {
      case Env.dev :
        {
          config = Config(
              appUrlKey: 'https://api.themoviedb.org/3',
          );
        }
        break;
      case Env.prod :
        {
          config = Config(
              appUrlKey: 'https://api.themoviedb.org/3',
          );
        }
        break;
    }
  }

  @override
  String toString() {
    return "appUrlKey : ${config.appUrlKey}\n"
        "appName : $appName\n"
        "jPushPkgName : ${config.jPushPkgName}\n"
        "jPushAppKey : ${config.jPushAppKey}\n"
        "jPushChannel : ${config.jPushChannel}\n";
  }
}