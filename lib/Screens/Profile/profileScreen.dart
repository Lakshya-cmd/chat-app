import 'dart:io';

import 'package:calling_app/Controller/AuthController.dart';
import 'package:calling_app/Controller/ImagePickerController.dart';
import 'package:calling_app/Controller/ProfileController.dart';
import 'package:calling_app/Widgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    AuthController authController = Get.put(AuthController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    TextEditingController name =
        TextEditingController(text: profileController.currentUser.value.name);
    TextEditingController email =
        TextEditingController(text: profileController.auth.currentUser!.email);
    TextEditingController phone = TextEditingController(
        text: profileController.currentUser.value.phoneNumber);
    TextEditingController about =
        TextEditingController(text: profileController.currentUser.value.about);
    RxString imagePath = "".obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                authController.logoutUser();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => isEdit.value
                              ? InkWell(
                                  onTap: () async {
                                    imagePath.value =
                                        await imagePickerController
                                            .pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        borderRadius:
                                            BorderRadius.circular(75)),
                                    child: imagePath == ""
                                        ? const Icon(Icons.add)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(75),
                                            child: Image.file(
                                              File(imagePath.value),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ))
                              : Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      borderRadius: BorderRadius.circular(75)),
                                  child: profileController.currentUser.value
                                                  .profileImage ==
                                              "" ||
                                          profileController.currentUser.value
                                                  .profileImage ==
                                              null
                                      ? const Icon(Icons.image)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(75),
                                          child: Image.file(
                                            File(profileController.currentUser
                                                    .value.profileImage ??
                                                ""),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() => TextField(
                            controller: name,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                                filled: isEdit.value,
                                labelText: "Name",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  size: 30,
                                )),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(() => TextField(
                            controller: about,
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                                filled: isEdit.value,
                                labelText: "About",
                                prefixIcon: const Icon(
                                  Icons.info,
                                  size: 30,
                                )),
                          )),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: email,
                        enabled: isEdit.value,
                        decoration: InputDecoration(
                            filled: isEdit.value,
                            labelText: "Email",
                            prefixIcon: const Icon(
                              Icons.alternate_email_rounded,
                              size: 30,
                            )),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => TextField(
                          controller: phone,
                          enabled: isEdit.value,
                          decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: "Number",
                              prefixIcon: const Icon(
                                Icons.phone,
                                size: 30,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => isEdit.value
                              ? PrimaryButton(
                                  btnName: "Save",
                                  icon: Icons.save,
                                  onTap: () {
                                    profileController.updateProfile(
                                        imagePath.value,
                                        name.text,
                                        about.text,
                                        phone.text);
                                    isEdit.value = false;
                                  })
                              : PrimaryButton(
                                  btnName: "Edit",
                                  icon: Icons.edit,
                                  onTap: () {
                                    isEdit.value = true;
                                  }))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
