import 'package:calling_app/Controller/GroupController.dart';
import 'package:calling_app/Screens/GroupChat/groupChatScreen.dart';
import 'package:calling_app/Screens/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(() {
      return ListView(
        children: groupController.groupList.map((group) {
          return InkWell(
            onTap: () {
              Get.to(GroupChatScreen(groupModel: group));
            },
            child: ChatTile(
                name: group.name!,
                imageURL: group.profileUrl == "" ? "" : group.profileUrl!,
                lastChat: "Group Created",
                lastTime: "Just now"),
          );
        }).toList(),
      );
    });
  }
}
