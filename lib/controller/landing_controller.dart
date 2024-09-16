import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/base/state_controller.dart';
import 'package:movie_db/page/home_page.dart';
import 'package:movie_db/page/movies_page.dart';
import 'package:movie_db/page/view_pager_page.dart';

class TabBarData {
  final IconData icon;
  final Widget page;
  final String? title;

  TabBarData({
    required this.icon,
    required this.page,
    this.title
  });
}

class LandingController extends StateController {

  final List<TabBarData> tabsList = [
    TabBarData(
        icon: Icons.home,
        page: const HomePage(),
        title: 'Home',
    ),
    TabBarData(
        icon: Icons.movie,
        page: const MoviesPage(),
        title: 'Movies'
    ),
    TabBarData(
        icon: Icons.trending_up,
        page: const ViewPagerPage(),
        title: 'Trending'
    )
  ];

  int get tabListLength => tabsList.length;

  final tabIndex = 0.obs;
}