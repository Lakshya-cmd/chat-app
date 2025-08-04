import 'package:calling_app/Config/Images.dart';
import 'package:calling_app/Controller/ChatController.dart';
import 'package:calling_app/Controller/ImagePickerController.dart';
import 'package:calling_app/Model/UserModel.dart';
import 'package:calling_app/Widgets/imagePickerBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageSendingBox extends StatelessWidget {
  final UserModel userModel;
  const MessageSendingBox({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    ChatController chatController = Get.put(ChatController());
    ImagePickerController imagePickerController =
        Get.put(ImagePickerController());
    RxString message = "".obs;
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Container(
              height: 30,
              width: 30,
              child: SvgPicture.asset(
                AssetImages.emojiSVG,
                width: 25,
              )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: TextField(
            onChanged: (value) {
              message.value = value;
            },
            controller: messageController,
            decoration: InputDecoration(
                filled: false,
                hintText: "Type message ...",
                hintStyle: Theme.of(context).textTheme.labelLarge),
          )),
          const SizedBox(
            width: 8,
          ),
          Obx(() => chatController.selectedImagePath.value == ""
              ? InkWell(
                  onTap: () async {
                    ImagePickerBottomSheet(
                        context,
                        chatController.selectedImagePath,
                        imagePickerController);
                  },
                  child: Container(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        AssetImages.gallerySVG,
                        width: 25,
                      )),
                )
              : const SizedBox()),
          const SizedBox(
            width: 8,
          ),
          Obx(() => message.value != "" ||
                  chatController.selectedImagePath.value != ""
              ? InkWell(
                  onTap: () {
                    if (messageController.text.trim().isNotEmpty ||
                        chatController.selectedImagePath.value.isNotEmpty) {
                      chatController.sendMessage(userModel.id!,
                          messageController.text.trim(), userModel);
                      messageController.clear();
                      message.value = "";
                    }
                  },
                  child: chatController.isLoading.value
                      ? const CircularProgressIndicator()
                      : Container(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            AssetImages.sendSVG,
                            width: 25,
                          ),
                        ),
                )
              : Container(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    AssetImages.micSVG,
                    width: 25,
                  ))),
        ],
      ),
    );
  }
}
