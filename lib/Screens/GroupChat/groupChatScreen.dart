import 'dart:io';

import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Controller/GroupController.dart';
import 'package:calling_app/Model/ChatModel.dart';
import 'package:calling_app/Model/GroupModel.dart';
import 'package:calling_app/Screens/Chat/Widget/chatBubble.dart';
import 'package:calling_app/Screens/GroupChat/Widget/GroupMessageSendingBox.dart';
import 'package:calling_app/Screens/GroupInfo/GroupInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupChatScreen extends StatelessWidget {
  final GroupModel groupModel;
  const GroupChatScreen({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
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
              Get.to(GroupInfoScreen(
                groupModel: groupModel,
              ));
            },
            child: Row(
              children: [
                groupModel.profileUrl == null || groupModel.profileUrl == ""
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
                            File(groupModel.profileUrl!),
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
                      groupModel.name ?? "Group",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      "Online",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
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
                      stream: groupController.getGroupMessages(groupModel.id!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        }

                        if (snapshot.data == null) {
                          return const Center(
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
                                  status: "read",
                                  isComing: snapshot.data![index].senderId !=
                                      groupController.auth.currentUser!.uid);
                            },
                          );
                        }
                      },
                    ),
                    Obx(() => groupController.selectedImagePath.value != ""
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
                                        image: FileImage(File(groupController
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
                                          groupController
                                              .selectedImagePath.value = "";
                                        },
                                        icon: const Icon(Icons.close)))
                              ],
                            ),
                          )
                        : Container())
                  ],
                ),
              ),
              GroupMessageSendingBox(groupModel: groupModel)
            ],
          ),
        ));
  }
}
