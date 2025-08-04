import 'package:calling_app/Screens/Auth/Widgets/LoginForm.dart';
import 'package:calling_app/Screens/Auth/Widgets/SignUpForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isLogin = true.obs;
    return Container(
      padding: const EdgeInsets.all(20),
      // height: 400,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          isLogin.value = true;
                        },
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: isLogin.value
                                  ? Theme.of(context).textTheme.bodyLarge
                                  : Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: isLogin.value ? 100 : 0,
                              height: 3,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(100)),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          isLogin.value = false;
                        },
                        child: Column(
                          children: [
                            Text(
                              "Sign Up",
                              style: isLogin.value
                                  ? Theme.of(context).textTheme.labelLarge
                                  : Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: isLogin.value ? 0 : 100,
                              height: 3,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(100)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => isLogin.value ? const LoginForm() : const Signupform())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
