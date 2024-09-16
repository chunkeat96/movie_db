import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/movies_sub_controller.dart';
import 'package:movie_db/model/discover_movie_model.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/widget/load_image.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MoviesSubPage extends StatefulWidget {
  final int genreId;

  const MoviesSubPage({super.key, required this.genreId});

  @override
  State<MoviesSubPage> createState() => _MoviesSubPageState();
}

class _MoviesSubPageState extends State<MoviesSubPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MoviesSubController>(
      init: MoviesSubController(widget.genreId),
      global: false,
      builder: (controller) {
        return NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels > 0) {
              if (controller.scrollOnTop.value) {
                controller.scrollOnTop.value = false;
              }
            } else {
              controller.scrollOnTop.value = true;
            }
            return true;
          },
          child: Stack(
            children: [
              SmartRefresher(
                controller: controller.refreshController,
                scrollController: controller.scrollController,
                onLoading: controller.loadNextPage,
                onRefresh: controller.refreshList,
                enablePullUp: !controller.lastPage,
                child: MasonryGridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  itemCount: controller.list.length,
                  itemBuilder: (context, index) {
                    return _buildMoviesCard(controller.list.elementAt(index));
                  },
                ),
              ),

              Obx(() => Visibility(
                visible: !controller.scrollOnTop.value,
                child: Positioned(
                    bottom: 24.0,
                    right: 24.0,
                    child: InkWell(
                      onTap: () {
                        controller.scrollController.animateTo(0, duration: 500.milliseconds, curve: Curves.easeInOut);
                      },
                      child: Container(
                        width: 55.0,
                        height: 55.0,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoviesCard(Results data) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.movieDetailsPage, arguments: data.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoadImage(
              data.posterPath.baseImageUrl,
              height: 250.0,
              fit: BoxFit.cover,
              holderImg: 'ImageDefault',
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? '',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 16.0
                    ),
                  ),
                  const SizedBox(height: 4.0,),
                  Text(
                    data.releaseDate ?? '',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
