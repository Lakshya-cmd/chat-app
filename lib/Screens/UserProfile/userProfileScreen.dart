import 'package:calling_app/Controller/AuthController.dart';
import 'package:calling_app/Model/UserModel.dart';
import 'package:calling_app/Screens/UserProfile/Widget/UserInfo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel userModel;
  const UserProfileScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Get.toNamed("/updateProfilePage");
        //       },
        //       icon: Icon(Icons.edit)),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            LoginUserInfo(
              profileImage: userModel.profileImage ?? "",
              userName: userModel.name ?? "User",
              userEmail: userModel.email ?? "",
            ),
            // Spacer(),
            // ElevatedButton(
            //     onPressed: () {
            //       authController.logoutUser();
            //     },
            //     child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
