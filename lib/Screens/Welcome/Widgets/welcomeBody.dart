import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Config/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetImages.boyPic),
            SvgPicture.asset(AssetImages.connectSVG),
            Image.asset(AssetImages.girlPic),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          WelcomeScreenstring.nowYourAre,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          WelcomeScreenstring.connected,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          WelcomeScreenstring.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
