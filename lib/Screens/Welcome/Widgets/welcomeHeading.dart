import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Config/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetImages.appIconSVG,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppString.appName,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(letterSpacing: 2.5),
        ),
      ],
    );
  }
}
