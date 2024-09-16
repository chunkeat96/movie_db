import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/home_controller.dart';
import 'package:movie_db/model/popular_model.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/widget/load_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return ListView(
          padding: const EdgeInsets.only(bottom: 24.0),
          children: [
            _buildRowContent(title: 'Now Playing', list: controller.nowPlayingList),
            _buildRowContent(title: 'Popular', list: controller.popularList),
            _buildRowContent(title: 'Top Rated', list: controller.topRatedList),
            _buildRowContent(title: 'Upcoming', list: controller.upcomingList),
          ],
        );
      },
    );
  }

  Widget _buildRowContent({String? title, List<Results> list = const []}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Text(
            title ?? '',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 18.0
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: list.map((e) => _buildMovieCard(e)).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildMovieCard(Results data) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.movieDetailsPage, arguments: data.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          width: 180.0,
          height: 320.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoadImage(
                data.posterPath.baseImageUrl,
                height: 220.0,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0,),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: data.voteAverageColor
                      ),
                      child: Text(
                        data.voteAverage?.toString() ?? '',
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 12.0
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
