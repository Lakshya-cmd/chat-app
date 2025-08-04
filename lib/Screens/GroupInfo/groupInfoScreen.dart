import 'package:calling_app/Controller/AuthController.dart';
import 'package:calling_app/Model/GroupModel.dart';
import 'package:calling_app/Screens/GroupInfo/Widget/groupMemberInfo.dart';
import 'package:calling_app/Screens/Home/Widget/chatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupInfoScreen extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfoScreen({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [
          IconButton(
              onPressed: () {
                // Get.toNamed("/updateProfilePage");
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            GroupMemberInfo(
              groupId: groupModel.id!,
              profileImage: groupModel.profileUrl ?? "",
              userName: groupModel.name ?? "Group",
              userEmail: groupModel.description ?? "No description given",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Members",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: groupModel.members!
                  .map((member) => ChatTile(
                      imageURL: member.profileImage ?? "",
                      name: member.name ?? "Group",
                      lastChat: member.about ?? "",
                      lastTime: member.role == "admin" ? "Admin" : "Member"))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
