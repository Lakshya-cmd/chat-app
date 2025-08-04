import 'dart:io';

import 'package:calling_app/Config/Colors.dart';
import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Controller/GroupController.dart';
import 'package:calling_app/Controller/ProfileController.dart';
import 'package:calling_app/Model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GroupMemberInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userEmail;
  final String groupId;
  const GroupMemberInfo(
      {super.key,
      required this.profileImage,
      required this.userName,
      required this.userEmail,
      required this.groupId});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    GroupController groupController = Get.put(GroupController());
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profileImage == ""
                      ? Image.asset(AssetImages.boyPic)
                      : Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              File(profileImage),
                              // width: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.background),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AssetImages.callSVG,
                          width: 15,
                          color: voiceCallIconColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Call",
                          style: TextStyle(color: voiceCallIconColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.background),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AssetImages.videoCallSVG,
                          width: 15,
                          color: videoCallIconColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Video",
                          style: TextStyle(
                            color: videoCallIconColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      var newMember = UserModel(
                        name: "Manvendra",
                        email: "manvendra@gmail.com",
                        profileImage: "",
                        role: "user",
                      );
                      groupController.addMemberToGroup(groupId, newMember);
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.background),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AssetImages.add_UserSVG,
                            width: 15,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Add",
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
