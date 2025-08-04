import 'dart:developer';

import 'package:calling_app/Controller/ChatController.dart';
import 'package:calling_app/Controller/ContactController.dart';
import 'package:calling_app/Controller/ProfileController.dart';
import 'package:calling_app/Screens/Chat/chatScreen.dart';
import 'package:calling_app/Screens/Contacts/Widget/contactSearch.dart';
import 'package:calling_app/Screens/Contacts/Widget/newContactTile.dart';
import 'package:calling_app/Screens/Groups/NewGroup/NewGroup.dart';
import 'package:calling_app/Screens/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnable = false.obs;

    ChatController chatController = Get.put(ChatController());
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          Obx(() {
            return IconButton(
                onPressed: () {
                  isSearchEnable.value = !isSearchEnable.value;
                },
                icon: Icon(isSearchEnable.value
                    ? Icons.cancel
                    : Icons.search_outlined));
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Obx(() {
              return isSearchEnable.value
                  ? const ContactSearch()
                  : const SizedBox();
            }),
            const SizedBox(height: 10),
            NewContactTile(
                text: "Contact",
                onTap: () {},
                icon: Icons.person_add_alt_1_rounded),
            const SizedBox(height: 10),
            NewContactTile(
              text: "Group",
              onTap: () {
                Get.to(const NewGroup());
              },
              icon: Icons.group_add,
            ),
            const SizedBox(
              height: 15,
            ),
            const Row(
              children: [
                Text("Contacts on Friend Line"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => Column(
                  children: contactController.userList
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            Get.to(ChatScreen(userModel: e));
                            String roomId = chatController.getRoomId(e.id!);
                            log(roomId);
                          },
                          child: ChatTile(
                              imageURL: e.profileImage ??
                                  "", // To be completed later!!
                              name: e.name ?? "User",
                              lastChat: e.about ?? "Hey! Whats'app",
                              lastTime: e.email ==
                                      profileController.currentUser.value.email
                                  ? "You"
                                  : ""),
                        ),
                      )
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }
}
