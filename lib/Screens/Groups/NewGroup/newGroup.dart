import 'package:calling_app/Controller/ContactController.dart';
import 'package:calling_app/Controller/GroupController.dart';
import 'package:calling_app/Screens/Groups/NewGroup/groupTitle.dart';
import 'package:calling_app/Screens/Groups/NewGroup/SelectedMembersList.dart';
import 'package:calling_app/Screens/Home/Widget/ChatTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    ContactController contactController = Get.put(ContactController());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Group"),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupController.groupMembers.isEmpty
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupController.groupMembers.isEmpty) {
              Get.snackbar("Error", "Please select atleast one member",
                  barBlur: 50, backgroundColor: Colors.red.withOpacity(0.4));
            } else {
              Get.to(const GroupTitle());
            }
          },
          child: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SelectedMembers(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Contacts on Friend Line",
                  style: Theme.of(context).textTheme.labelMedium,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: contactController.getContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
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
                        child: Text("No Contacts..."),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //
                              //     .add(snapshot.data![index]);
                              if (groupController.groupMembers
                                  .contains(snapshot.data![index])) {
                                groupController.groupMembers
                                    .remove(snapshot.data![index]);
                              } else {
                                groupController.groupMembers
                                    .add(snapshot.data![index]);
                              }
                            },
                            child: ChatTile(
                                imageURL:
                                    snapshot.data![index].profileImage ?? "",
                                name: snapshot.data![index].name!,
                                lastChat: snapshot.data![index].about ?? "",
                                lastTime: ""),
                          );
                        },
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
