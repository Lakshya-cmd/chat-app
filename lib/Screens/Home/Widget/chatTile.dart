import 'dart:io';

import 'package:calling_app/Config/Images.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String imageURL;
  final String name;
  final String lastChat;
  final String lastTime;
  const ChatTile(
      {super.key,
      required this.imageURL,
      required this.name,
      required this.lastChat,
      required this.lastTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: imageURL == ""
            ? Image.asset(AssetImages.boyPic)
            : Container(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    File(imageURL),
                    // width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          lastChat,
          style: Theme.of(context).textTheme.labelMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing:
            Text(lastTime, style: Theme.of(context).textTheme.labelMedium),
      ),
    );
  }
}
