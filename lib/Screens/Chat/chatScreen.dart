import 'dart:developer';
import 'dart:io';

import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Controller/CallController.dart';
import 'package:calling_app/Controller/ChatController.dart';
import 'package:calling_app/Controller/ProfileController.dart';
import 'package:calling_app/Model/ChatModel.dart';
import 'package:calling_app/Model/UserModel.dart';
import 'package:calling_app/Screens/Call/audioCallScreen.dart';
import 'package:calling_app/Screens/Chat/Widget/MessageSendingBox.dart';
import 'package:calling_app/Screens/Chat/Widget/chatBubble.dart';
import 'package:calling_app/Screens/UserProfile/userProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;
  const ChatScreen({super.key, required this.userModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    ChatController chatController = Get.put(ChatController());
    ProfileController profileController = Get.put(ProfileController());

    String currentUserId = profileController.currentUser.value.id!;
    String chatRoomId = getRoomId(widget.userModel.id!);
    log(chatRoomId);

    chatController.markMessagesAsRead(chatRoomId);
  }

  String getRoomId(String targetUserId) {
    ProfileController profileController = Get.put(ProfileController());

    String currentUserId = profileController.currentUser.value.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    CallController callController = Get.put(CallController());
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController messageController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Theme.of(context).colorScheme.primaryContainer,
          leadingWidth: 28,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          title: InkWell(
            onTap: () {
              Get.to(UserProfileScreen(
                userModel: widget.userModel,
              ));
            },
            child: Row(
              children: [
                widget.userModel.profileImage == null ||
                        widget.userModel.profileImage == ""
                    ? Container(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(AssetImages.boyPic)),
                      )
                    : Container(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            File(widget.userModel.profileImage!),
                            // width: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userModel.name ?? "User",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    StreamBuilder(
                        stream: chatController.getStatus(widget.userModel.id!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(".....");
                          } else {
                            return Text(
                              snapshot.data!.status ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: snapshot.data!.status == "Online"
                                          ? Colors.white
                                          : Colors.grey),
                            );
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(AudioCallScreen(target: widget.userModel));
                  callController.callAction(
                    profileController.currentUser.value,
                    widget.userModel,
                    "Dialing",
                  );
                },
                icon: const Icon(
                  Icons.phone,
                  size: 25,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.video_call,
                  size: 25,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder<List<ChatModel>>(
                      stream: chatController.getMessages(widget.userModel.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }

                        if (snapshot.data == null) {
                          return Center(
                            child: Text("Start Chatting..."),
                          );
                        } else {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              DateTime timestamp = DateTime.parse(
                                  snapshot.data![index].timestamp!);
                              String formattedTime =
                                  DateFormat('hh:mm a').format(timestamp);
                              return ChatBubble(
                                  message: snapshot.data![index].message!,
                                  imageURL:
                                      snapshot.data![index].imageUrl ?? "",
                                  time: formattedTime,
                                  status: snapshot.data![index].readStatus ??
                                      "unread",
                                  isComing: snapshot.data![index].senderId !=
                                      chatController.auth.currentUser!.uid);
                            },
                          );
                        }
                      },
                    ),
                    Obx(() => chatController.selectedImagePath.value != ""
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Stack(
                              children: [
                                Container(
                                  height: 500,
                                  // width: 10,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(File(chatController
                                            .selectedImagePath.value)),
                                        fit: BoxFit.contain),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () {
                                          chatController
                                              .selectedImagePath.value = "";
                                        },
                                        icon: Icon(Icons.close)))
                              ],
                            ),
                          )
                        : Container())
                  ],
                ),
              ),
              MessageSendingBox(userModel: widget.userModel)
            ],
          ),
        ));
  }
}
