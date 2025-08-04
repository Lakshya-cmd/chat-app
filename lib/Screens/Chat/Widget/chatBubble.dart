import 'dart:io';

import 'package:calling_app/Config/Colors.dart';
import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Controller/ChatController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String imageURL;
  final String time;
  final String status;
  final bool isComing;
  const ChatBubble(
      {super.key,
      required this.message,
      required this.imageURL,
      required this.time,
      required this.status,
      required this.isComing});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment:
            isComing ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width / 1.4,
            ),
            decoration: BoxDecoration(
                color: isComing
                    ? Theme.of(context).colorScheme.primaryContainer
                    : dSendingChatColor,
                borderRadius: isComing
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(5),
                      )),
            child: imageURL == ""
                ? Text(message)
                : Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(File(imageURL))),
                      message == ""
                          ? Container()
                          : const SizedBox(
                              height: 8,
                            ),
                      message == ""
                          ? Container()
                          : Row(
                              children: [
                                Text(message),
                              ],
                            )
                    ],
                  ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment:
                isComing ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              isComing
                  ? Text(
                      time,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  : Row(
                      children: [
                        Text(
                          time + " ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          AssetImages.chatStatusSVG,
                          width: 20,
                          color:
                              status == "read" ? Colors.blue[300] : Colors.grey,
                        ),
                      ],
                    )
            ],
          )
        ],
      ),
    );
  }
}
