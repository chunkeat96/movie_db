import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/cast_details_controller.dart';
import 'package:movie_db/utils/data_extension.dart';
import 'package:movie_db/widget/custom_app_bar.dart';
import 'package:movie_db/widget/load_image.dart';

class CastDetailsPage extends StatelessWidget {
  const CastDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CastDetailsController>(
      init: CastDetailsController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(title: controller.name,),
          body: controller.showViewByState(
            child: RefreshIndicator(
              onRefresh: () => controller.refreshPage(),
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: LoadImage(
                          controller.profilePath,
                          width: 115.0,
                          height: 180.0,
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTitleText(
                              context,
                              title: 'Known For',
                              text: controller.knownFor
                            ),
                            _buildTitleText(
                                context,
                                title: 'Birthday',
                                text: controller.birthday
                            ),
                            _buildTitleText(
                                context,
                                title: 'Place of Birth',
                                text: controller.placeOfBirth
                            ),
                            _buildTitleText(
                                context,
                                title: 'Also Known As',
                                text: controller.aka
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8.0,),
                  Text(
                    'Known For',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 15.0
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.cutCombinedCredits.map((e) => Card(
                        margin: const EdgeInsets.only(right: 12.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: SizedBox(
                          width: 130.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LoadImage(
                                e.posterPath.baseImageUrl,
                                height: 170.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.title ?? '',
                                      style: Theme.of(context).textTheme.displayMedium,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )).toList(),
                    ),
                  ),
                  _buildTitleText(context, title: 'Biography', text: controller.biography)
                ],
              ),
            ),
          ),
        );
      }
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
                fontSize: 15.0
            ),
          ),
          const SizedBox(height: 3.0,),
          Text(
            text?.isNotEmpty == true ? text! : '-',
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ),
    );
  }
}
