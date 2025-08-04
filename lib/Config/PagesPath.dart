import 'package:calling_app/Screens/Auth/authScreen.dart';
import 'package:calling_app/Screens/Contacts/ContactScreen.dart';
import 'package:calling_app/Screens/Home/homeScreen.dart';
import 'package:calling_app/Screens/Welcome/welcomeScreen.dart';
import 'package:get/get.dart';

var pagesPath = [
  GetPage(
      name: "/authPage",
      page: () => const AuthScreen(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/homePage",
      page: () => const HomeScreen(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/welcomePage",
      page: () => const WelcomeScreen(),
      transition: Transition.rightToLeft),
  GetPage(
      name: "/contactPage",
      page: () => const ContactScreen(),
      transition: Transition.rightToLeft),
];
