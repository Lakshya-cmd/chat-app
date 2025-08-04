import 'package:calling_app/Controller/ChatController.dart';
import 'package:calling_app/Controller/ContactController.dart';
import 'package:calling_app/Controller/ProfileController.dart';
import 'package:calling_app/Screens/Chat/ChatScreen.dart';
import 'package:calling_app/Screens/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});
  @override
  void initState() async {
    ContactController contactController = Get.put(ContactController());
    contactController.getChatRoomList();
  }

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    ProfileController profileController = Get.put(ProfileController());
    ChatController chatController = Get.put(ChatController());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
          child: Obx(
            () => ListView(
                children: contactController.chatRoomList
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Get.to(ChatScreen(
                              userModel: (e.receiver!.id ==
                                      profileController.currentUser.value.id
                                  ? e.sender
                                  : e.receiver)!));
                        },
                        child: ChatTile(
                            imageURL: (e.receiver!.id ==
                                        profileController.currentUser.value.id
                                    ? e.sender!.profileImage
                                    : e.receiver!.profileImage) ??
                                "",
                            name: (e.receiver!.id ==
                                    profileController.currentUser.value.id
                                ? e.sender!.name
                                : e.receiver!.name)!,
                            lastChat: e.lastMessage ?? "",
                            lastTime: e.lastMessageTimestamp ?? ""),
                      ),
                    )
                    .toList()),
          ),
          onRefresh: () async {
            contactController.getChatRoomList();
          }),
    );
  }
}
