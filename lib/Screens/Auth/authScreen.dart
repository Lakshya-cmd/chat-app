import 'package:calling_app/Screens/Auth/Widgets/authPageBody.dart';
import 'package:calling_app/Screens/Welcome/Widgets/welcomeHeading.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeading(),
                SizedBox(
                  height: 40,
                ),
                AuthPageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
