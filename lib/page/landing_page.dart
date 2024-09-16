import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/controller/landing_controller.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/utils/toast_utils.dart';
import 'package:movie_db/widget/custom_app_bar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  bool _canPop = false;

  _isExit(bool pop) {
    if (!pop) {
      ToastUtils.show(message: 'Click again to exit app');
      Future.delayed(2500.milliseconds, () {
        setState(() {
          _canPop = false;
        });
      });
      setState(() {
        _canPop = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: _isExit,
      child: GetBuilder<LandingController>(
        init: LandingController(),
        builder: (controller) {
          return DefaultTabController(
            length: controller.tabListLength,
            child: Scaffold(
              appBar: CustomAppBar(
                title: 'The Movie DB',
                showBack: false,
                actions: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.searchPage);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                child: Obx(() => TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.cyan,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontSize: 10.0
                  ),
                  onTap: (index) {
                    controller.tabIndex.value = index;
                  },
                  tabs: List.generate(controller.tabListLength, (index) {
                    final title = controller.tabsList.elementAt(index).title;
                    return Tab(
                      text: title,
                      iconMargin: const EdgeInsets.only(bottom: 4.0),
                      icon: Icon(
                        controller.tabsList.elementAt(index).icon,
                        size: 25.0,
                        color: controller.tabIndex.value == index ? Colors.cyan : Colors.grey,
                      ),
                    );
                  }),
                ),
                ),
              ),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: controller.tabsList.map((e) => e.page).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
