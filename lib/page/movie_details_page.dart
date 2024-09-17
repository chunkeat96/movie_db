import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/movie_details_controller.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/routes/arguments.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/widget/load_image.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MovieDetailsController>(
        init: MovieDetailsController(),
        builder: (controller) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget> [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  leading: InkWell(
                    onTap: () => Get.back(),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: LoadAssetImage(
                        'arrowleft2',
                        width: 24.0,
                        height: 24.0,
                        color: innerBoxIsScrolled ? Colors.black : controller.firstVideo.isNotEmpty ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  title: Text(
                    innerBoxIsScrolled ? controller.title : '',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 16.0
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: controller.firstVideo.isNotEmpty ? InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri(controller.firstVideo),
                      ),
                      initialSettings: controller.options,
                      onPermissionRequest: (controller, request) async {
                        return PermissionResponse(
                          resources: request.resources,
                          action: PermissionResponseAction.GRANT,
                        );
                      },
                    ) : LoadImage(
                      controller.posterPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ];
            },
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                RichText(
                    text: TextSpan(
                      text: controller.title,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 18.0
                      ),
                      children: [
                        TextSpan(
                          text: controller.runtime,
                          style: Theme.of(context).textTheme.displaySmall
                        )
                      ]
                    )
                ),
                const SizedBox(height: 3.0,),
                Text(
                  controller.releaseDate,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 3.0,),
                Text(
                  controller.displayGenres,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 6.0,),
                Text(
                  'Casts',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 18.0
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: controller.cutCastsList.map((e) => Card(
                      margin: const EdgeInsets.only(right: 12.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.castDetailsPage, arguments: e.id);
                        },
                        child: SizedBox(
                          width: 115.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LoadImage(
                                e.profilePath.baseImageUrl,
                                height: 155.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.name ?? '',
                                      style: Theme.of(context).textTheme.displayLarge,
                                    ),
                                    const SizedBox(height: 3.0,),
                                    Text(
                                      e.character ?? '',
                                      style: Theme.of(context).textTheme.displaySmall,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ),
                _buildTitleText(
                    context,
                    title: 'Overview',
                    text: controller.overview
                ),
                _buildTitleText(
                    context,
                    title: 'Status',
                    text: controller.status
                ),
                _buildTitleText(
                    context,
                    title: 'Original Language',
                    text: controller.oriLanguage
                ),
                _buildTitleText(
                    context,
                    title: 'Budget',
                    text: controller.displayBudget
                ),
                _buildTitleText(
                    context,
                    title: 'Revenue',
                    text: controller.displayRevenue
                ),
                Visibility(
                  visible: controller.oriVideosList.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Trailers',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 18.0
                      ),
                    ),
                  ),
                ),
                Column(
                  children: List.generate(controller.oriVideosList.length, (index) => InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.webViewPage, arguments: WebViewArguments(
                          url: controller.videosList.elementAt(index),
                          title: controller.oriVideosList.elementAt(index).name
                      ));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              LoadImage(
                                controller.posterPath,
                                width: 120.0,
                                height: 120.0,
                              ),
                              Icon(
                                Icons.play_circle_outline,
                                color: Colors.grey[300],
                                size: 45.0,
                              )
                            ],
                          ),
                          const SizedBox(width: 12.0,),
                          Expanded(
                            child: Text(
                              controller.oriVideosList.elementAt(index).name ?? '',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleText(BuildContext context, {String? title, String? text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 18.0
            ),
          ),
          const SizedBox(height: 8.0,),
          Text(
            text?.isNotEmpty == true ? text! : '-',
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}
