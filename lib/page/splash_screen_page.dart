import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/routes/app_routes.dart';
import 'package:movie_db/utils/image_extension.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> with TickerProviderStateMixin {

  late AnimationController animationController;
  late Animation<Offset> translateAnimTop;
  late Animation<Offset> translateAnimBottom;

  late Image imageIconTop;
  late Image imageIconBottom;

  @override
  void initState() {
    super.initState();
    imageIconTop = Image.asset('IconTop'.imagePath(), height: 80.0, fit: BoxFit.contain,);
    imageIconBottom = Image.asset('IconBottom'.imagePath(), height: 80.0, fit: BoxFit.contain,);

    animationController = AnimationController(vsync: this, duration: 3000.milliseconds)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.toNamed(AppRoutes.landingPage);
      }
    });

    translateAnimTop = Tween<Offset>(begin: const Offset(-1.0, 0), end: const Offset(0, 0)).animate(
        CurvedAnimation(parent: animationController, curve: const Interval(
          0.0, 0.5,
          curve: Curves.easeInOut,
        ))
    );

    translateAnimBottom = Tween<Offset>(begin: const Offset(1.0, 0), end: const Offset(0, 0)).animate(
        CurvedAnimation(parent: animationController, curve: const Interval(
          0.5, 1.0,
          curve: Curves.easeInOut,
        ))
    );

    animationController.forward();
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageIconTop.image, context);
    precacheImage(imageIconBottom.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FractionalTranslation(
                  translation: translateAnimTop.value,
                  child: imageIconTop
              ),
              const SizedBox(height: 8.0,),
              FractionalTranslation(
                  translation: translateAnimBottom.value,
                  child: imageIconBottom
              ),
            ],
          );
        }
      ),
    );
  }
}
