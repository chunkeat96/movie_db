import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/global/local_storage.dart';
import 'package:movie_db/model/recent_searches_model.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/widget/custom_text_field.dart';
import 'package:movie_db/widget/load_image.dart';
import 'package:movie_db/controller/search_controller.dart' as controller;

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<controller.SearchController>(
          init: controller.SearchController(),
          builder: (controller) {
            return Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: LoadAssetImage(
                            'arrowleft2',
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          outlineBorder: false,
                          hintText: 'Search Movies...',
                          autoFocus: true,
                          textInputAction: TextInputAction.search,
                          onChanged: (text) {
                            controller.searchQuery.value = text;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Visibility(
                        visible: controller.searchQuery.value.isEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: controller.recentSearchList.isNotEmpty,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recent Searches',
                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                          fontSize: 16.0
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.clearRecentSearchList();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Clear',
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ...controller.recentSearchList.map((e) => _buildSearchContent(
                                context, id: e.id, poster: e.poster, title: e.title, overview: e.overview, onTap: () {
                              Get.toNamed(AppRoutes.movieDetailsPage, arguments: e.id);
                            })
                            ),
                          ],
                        ),
                      ),
                      ...controller.searchList.map((e) => _buildSearchContent(
                          context, id: e.id, poster: e.posterPath, title: e.title, overview: e.overview, onTap: () async{
                        await Get.find<LocalStorage>().setRecentSearchesList(RecentSearchesModel(
                          id: e.id,
                          poster: e.posterPath,
                          title: e.title,
                          overview: e.overview,
                        ));
                        controller.setRecentSearchList();
                        Get.toNamed(AppRoutes.movieDetailsPage, arguments: e.id);
                      })
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchContent(BuildContext context, {int? id, String? poster,
    String? title, String? overview, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            LoadImage(
              poster.baseImageUrl,
              width: 100.0,
              height: 150.0,
              holderImg: 'ImageDefault',
            ),
            const SizedBox(width: 16.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 16.0
                    ),
                  ),
                  const SizedBox(height: 5.0,),
                  Text(
                    overview ?? '',
                    style: Theme.of(context).textTheme.displayMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
