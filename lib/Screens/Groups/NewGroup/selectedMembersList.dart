import 'dart:io';

import 'package:calling_app/Controller/GroupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedMembers extends StatelessWidget {
  const SelectedMembers({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: groupController.groupMembers
              .map((e) => Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                FileImage(File(e.profileImage ?? "")),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                groupController.groupMembers.remove(e);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(100)),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
