import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Config/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeFooterButton extends StatelessWidget {
  const WelcomeFooterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      onSubmit: () {
        Get.offAllNamed("/authPage");
      },
      sliderButtonIcon: Container(
          width: 25, height: 25, child: SvgPicture.asset(AssetImages.plugSVG)),
      submittedIcon: SvgPicture.asset(AssetImages.connectSVG),
      // animationDuration: Duration(seconds: 3),
      innerColor: Theme.of(context).colorScheme.primary,
      outerColor: Theme.of(context).colorScheme.primaryContainer,
      text: WelcomeScreenstring.slider,
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }
}
