import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/view_pager_controller.dart';
import 'package:movie_db/model/popular_model.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/widget/custom_button.dart';
import 'package:movie_db/widget/load_image.dart';
import 'package:preload_page_view/preload_page_view.dart';

class ViewPagerPage extends StatefulWidget {
  const ViewPagerPage({super.key});

  @override
  State<ViewPagerPage> createState() => _ViewPagerPageState();
}

class _ViewPagerPageState extends State<ViewPagerPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ViewPagerController>(
      init: ViewPagerController(),
      builder: (controller) {
        return PreloadPageView.builder(
          itemCount: controller.list.length,
          preloadPagesCount: 3,
          itemBuilder: (context, position) => _buildContent(controller.list.elementAt(position)),
          onPageChanged: (position) {
            if (position == controller.list.length - 1) {
              if (!controller.lastPage) {
                controller.loadNextPage();
              }
            }
          },
        );
      },
    );
  }

  Widget _buildContent(Results data) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: LoadImage(
              data.posterPath.baseImageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title ?? '',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 15.0
                        ),
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
                ),
                CustomButton(
                  'Details',
                  onPressed: () {
                    Get.toNamed(AppRoutes.movieDetailsPage, arguments: data.id);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
