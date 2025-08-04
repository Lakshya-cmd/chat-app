import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Config/Strings.dart';
import 'package:calling_app/Controller/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetImages.appIconSVG,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppString.appName,
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
