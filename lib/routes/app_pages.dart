import 'package:movie_db/bindings/landing_binding.dart';
import 'package:movie_db/page/cast_details_page.dart';
import 'package:movie_db/page/landing_page.dart';
import 'package:get/get.dart';
import 'package:movie_db/page/movie_details_page.dart';
import 'package:movie_db/page/search_page.dart';
import 'package:movie_db/page/splash_screen_page.dart';
import 'package:movie_db/page/web_view_page.dart';

import 'app_routes.dart';

class AppPage {
  static final routes = [
    GetPage(
      name: AppRoutes.landingPage,
      page: () => const LandingPage(),
      binding: LandingBinding()
    ),
    GetPage(
      name: AppRoutes.movieDetailsPage,
      page: () => const MovieDetailsPage()
    ),
    GetPage(
        name: AppRoutes.webViewPage,
        page: () => const WebViewPage()
    ),
    GetPage(
        name: AppRoutes.searchPage,
        page: () => const SearchPage()
    ),
    GetPage(
        name: AppRoutes.castDetailsPage,
        page: () => const CastDetailsPage()
    ),
    GetPage(
        name: AppRoutes.splashScreenPage,
        page: () => const SplashScreenPage()
    )
  ];
}