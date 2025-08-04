import 'dart:io';

import 'package:calling_app/Controller/GroupController.dart';
import 'package:calling_app/Controller/ImagePickerController.dart';
import 'package:calling_app/Screens/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GroupTitle extends StatelessWidget {
  const GroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());

    RxString groupImagePath = "".obs;
    RxString groupName = "".obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group Details"),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupName.value.trim().isEmpty
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupName.value.trim().isEmpty) {
              Get.snackbar("Error", "Please enter group name",
                  barBlur: 50, backgroundColor: Colors.red.withOpacity(0.4));
              return;
            } else {
              groupController.createGroup(
                  groupName.value.trim(), groupImagePath.value);
            }
            groupName.value = "";
            groupImagePath.value = "";
          },
          child: groupController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Icon(
                  Icons.done,
                  size: 30,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Obx(
                        () => InkWell(
                          onTap: () async {
                            groupImagePath.value = await imagePickerController
                                .pickImage(ImageSource.gallery);
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(100)),
                            child: groupImagePath.value == ""
                                ? const Icon(
                                    Icons.group,
                                    size: 40,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(groupImagePath.value),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          onChanged: (value) {
                            groupName.value = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.group),
                            hintText: "Group Name",
                            hintStyle: Theme.of(context).textTheme.labelLarge,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: groupController.groupMembers.length,
                itemBuilder: (context, index) {
                  return ChatTile(
                      imageURL:
                          groupController.groupMembers![index].profileImage ??
                              "",
                      name: groupController.groupMembers![index].name!,
                      lastChat:
                          groupController.groupMembers![index].about ?? "",
                      lastTime: "");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
