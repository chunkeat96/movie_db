import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/movies_controller.dart';
import 'package:movie_db/page/movies_sub_page.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MoviesController>(
      init: MoviesController(),
      builder: (controller) {
        return DefaultTabController(
          length: controller.genreList.length,
          child: Column(
            children: [
              StatefulBuilder(
                builder: (context, state) {
                  final tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    state(() {});
                  });

                  return TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
                    tabs: List.generate(controller.genreList.length, (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: tabController.index == index ? Colors.cyan : Colors.black
                            ),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Text(
                            controller.genreList.elementAt(index).name ?? '',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: tabController.index == index ? Colors.cyan : Colors.black
                            )
                        ),
                      );
                    }),
                  );
                },
              ),
              Expanded(
                child: TabBarView(
                  children: controller.genreList.map((e) => MoviesSubPage(genreId: e.id ?? 0)).toList(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
