import 'package:calling_app/Config/Themes.dart';
import 'package:calling_app/Config/pagesPath.dart';
import 'package:calling_app/Screens/SplashScreen/splashScreen.dart';
import 'package:calling_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: FToastBuilder(),
      title: 'Friend Line',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      getPages: pagesPath,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: const SplashScreen(),
    );
  }
}
