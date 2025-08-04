import 'package:calling_app/Screens/Welcome/Widgets/WelcomeBody.dart';
import 'package:calling_app/Screens/Welcome/Widgets/WelcomeFooterButton.dart';
import 'package:calling_app/Screens/Welcome/Widgets/WelcomeHeading.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [WelcomeHeading(), WelcomeBody(), WelcomeFooterButton()],
        ),
      )),
    );
  }
}
