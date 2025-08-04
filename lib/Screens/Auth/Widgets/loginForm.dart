import 'package:calling_app/Controller/AuthController.dart';
import 'package:calling_app/Widgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    AuthController authController = Get.put(AuthController());
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: email,
          decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(Icons.alternate_email_outlined),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: password,
          decoration: const InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(Icons.password),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Obx(
          () => authController.isLoading.value
              ? const CircularProgressIndicator()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                        onTap: () {
                          authController.login(email.text, password.text);
                        },
                        btnName: "LOGIN",
                        icon: Icons.lock_open_outlined),
                  ],
                ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
