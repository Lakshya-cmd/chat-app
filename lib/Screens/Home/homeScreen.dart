import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Config/Strings.dart';
import 'package:calling_app/Controller/CallController.dart';
import 'package:calling_app/Controller/ContactController.dart';
import 'package:calling_app/Controller/ProfileController.dart';
import 'package:calling_app/Controller/StatusController.dart';
import 'package:calling_app/Screens/Contacts/ContactScreen.dart';
import 'package:calling_app/Screens/Groups/GroupScreen.dart';
import 'package:calling_app/Screens/Home/Widget/ChatList.dart';
import 'package:calling_app/Screens/Home/Widget/TabBar.dart';
import 'package:calling_app/Screens/Profile/profileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    ProfileController profileController = Get.put(ProfileController());
    ContactController contactController = Get.put(ContactController());
    StatusController statusController = Get.put(StatusController());
    CallController callController = Get.put(CallController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AssetImages.appIconSVG,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  contactController.getChatRoomList();
                },
                icon: const Icon(CupertinoIcons.search)),
            IconButton(
                onPressed: () {
                  Get.to(const ProfileScreen());
                },
                icon: const Icon(Icons.more_vert)),
          ],
          bottom: myTabBar(tabController, context),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            Get.to(const ContactScreen());
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          child: TabBarView(controller: tabController, children: [
            const ChatList(),
            const GroupScreen(),
            const ChatList(),
          ]),
        ));
  }
}
