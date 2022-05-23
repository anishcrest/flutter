import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_components/chat/chat_store.dart';
import 'package:common_components/helper/custom_shape.dart';
import 'package:common_components/model/chat_model.dart';
import 'package:common_components/repository/chat_repository.dart';
import 'package:common_components/sure_set_state.dart';
import 'package:common_components/utils/bottom_sheet_util.dart';
import 'package:common_components/utils/enum_utils.dart';
import 'package:common_components/utils/string_utils.dart';
import 'package:common_components/utils/time_utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ChatComponent extends StatefulWidget {
  final UsersEnum usersEnum;

  const ChatComponent({
    Key? key,
    required this.usersEnum,
  }) : super(key: key);

  @override
  _ChatComponentState createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  final ChatRepository chatRepository = ChatRepository();
  late ChatStore chatStore;

  ///controller for handle texts
  final TextEditingController messageController = TextEditingController();

  ///picker for handle image
  final ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    chatStore = ChatStore(chatRepository);
    chatStore.currentUser = EnumUtil.toStringEnum(widget.usersEnum);
    chatStore.oppositeUSer =
        widget.usersEnum == UsersEnum.user_one ? 'user_two' : 'user_one';

    messageController.addListener(() {
      sureSetState(this, () {});
    });

    chatStore.fetchChatListBasedOnId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            chatStore.updateIsOnline(false);
            chatStore.updateLastSeenTime();

            /*updateIsOnline(false);
            updateLastSecenTime();*/

            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.usersEnum == UsersEnum.user_one
                    ? AppString.user_one
                    : widget.usersEnum == UsersEnum.user_two
                        ? AppString.user_two
                        : '',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: 4,
              ),
              if (chatStore.isTyping.isNotEmpty &&
                  chatStore.isOnline.isNotEmpty)
                Text(
                  chatStore.isTyping.entries
                              .firstWhere((element) =>
                                  element.key != chatStore.currentUser)
                              .value ==
                          true
                      ? 'typing....'
                      : chatStore.isOnline.entries
                                  .firstWhere((element) =>
                                      element.key != chatStore.currentUser)
                                  .value ==
                              true
                          ? 'Online'
                          : 'Last Seen ${TimeUtil.newMessageTime(chatStore.lastSeen.entries.firstWhere((element) => element.key == chatStore.oppositeUSer).value)}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                ),
              SizedBox(
                height: 4,
              ),
            ],
          );
        }),
      ),
      body: Observer(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: chatStore.messageList.length,
                reverse: true,
                itemBuilder: (_, index) {
                  return MessageWidget(
                    chatModel: chatStore.messageList[index],
                    selectedUser: EnumUtil.toStringEnum(widget.usersEnum),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16)
                  .copyWith(bottom: 12, top: 6),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      maxLines: 4,
                      minLines: 1,
                      onChanged: (val) {
                        updateIsTyping(val);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppString.your_message,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                        isDense: true,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => showBottomSheet(),
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    padding: EdgeInsets.only(left: 8),
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: messageController.text.trim().isEmpty
                        ? null
                        : () => sendMessage(),
                    icon: Icon(
                      Icons.send,
                      color: messageController.text.trim().isEmpty
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.only(left: 8),
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  sendMessage({String? url}) {
    ///check if its text message
    String? message = messageController.text.trim().isNotEmpty
        ? messageController.text.trim()
        : null;

    messageController.clear();

    chatStore.sendMessage(message: message, url: url);
  }

  showBottomSheet() async {
    Uuid uuid = Uuid();

    ///fetch image file from image picker
    var file =
    await BottomSheetUtil.showImagePickerBottomSheet(context, imagePicker);

    if (file != null) {
      File imageFile = File(file.path);

      String selectedFileName =
      imageFile.uri.pathSegments[imageFile.uri.pathSegments.length - 1];
      String filePathName =
          'user/${EnumUtil.toStringEnum(widget.usersEnum)}/${uuid.v1() + selectedFileName.substring(selectedFileName.indexOf('.'))}';

      try {
        ///create reference of image file
        final reference = FirebaseStorage.instance.ref(filePathName);
        await reference.putFile(imageFile);

        var downloadUrl = await reference.getDownloadURL();

        ///store url into chat message
        sendMessage(url: downloadUrl);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  updateIsTyping(String text) async {
    ///check if is Type for current user false then do true
    if (chatStore.isTyping.entries
            .firstWhere((element) =>
                element.key == EnumUtil.toStringEnum(widget.usersEnum))
            .value ==
        false) {
      chatStore.updateIsTypingInFirebase(true);
    }

    ///check is user typing after 2 second then return other wise return
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (text == messageController.text.trim()) {
        chatStore.updateIsTypingInFirebase(false);
      }
    });
  }
}

class MessageWidget extends StatelessWidget {
  final ChatModel chatModel;
  final String selectedUser;

  const MessageWidget({
    Key? key,
    required this.chatModel,
    required this.selectedUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: selectedUser == chatModel.senderId
          ? _senderWidget(context)
          : _receiverWidget(context),
    );
  }

  Widget _senderWidget(BuildContext context) {
    Widget body = Container();

    if (chatModel.messageModel.content != null) {
      body = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 120),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade300,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                alignment: WrapAlignment.end,
                children: [
                  Text(
                    chatModel.messageModel.content!,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    TimeUtil.newMessageTime(chatModel.createdAt!),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white, height: -0, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          CustomPaint(painter: CustomShape(Colors.blue.shade300)),
        ],
      );
    }

    if (chatModel.messageModel.imageUrl != null) {
      body = GestureDetector(
        onTap: () =>
            showImageBottomSheet(context, chatModel.messageModel.imageUrl!),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: chatModel.messageModel.imageUrl!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 6,
              right: 6,
              child: Text(
                TimeUtil.newMessageTime(chatModel.createdAt!),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
            )
          ],
        ),
      );
    }

    return body;
  }

  Widget _receiverWidget(BuildContext context) {
    Widget body = Container();

    if (chatModel.messageModel.content != null) {
      body = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: CustomPaint(
              painter: CustomShape(Colors.grey),
            ),
          ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 120),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                alignment: WrapAlignment.end,
                children: [
                  Text(
                    chatModel.messageModel.content!,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    TimeUtil.newMessageTime(chatModel.createdAt!),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.white, height: -0, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (chatModel.messageModel.imageUrl != null) {
      body = GestureDetector(
        onTap: () =>
            showImageBottomSheet(context, chatModel.messageModel.imageUrl!),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: chatModel.messageModel.imageUrl!,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 6,
              right: 180,
              child: Text(
                TimeUtil.newMessageTime(chatModel.createdAt!),
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
            )
          ],
        ),
      );
    }

    return body;
  }

  showImageBottomSheet(BuildContext context, String url) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: CachedNetworkImage(
            imageUrl: url,
          ),
        );
      },
    );
  }
}

/*

///fetch Messages
fetchChatListBasedOnId() async {
  List<ChatModel> tempList = [];

  ///create Stream for incoming message
  FirebaseFirestore.instance
      .collection('chat')
      .doc('iau9GgGSQ8KxmzK075k5')
      .collection('ChatList')
      .snapshots()
      .map((event) => event.docs.map((e) => ChatModel.fromMap(e.data())))
      .listen((event) {
    chatList.clear();

    event.forEach((element) {
      tempList.add(element);

      ///sort by created time
      tempList.sort((a, b) {
        return b.createdAt!.compareTo(a.createdAt!);
      });

      chatList = tempList;

      sureSetState(this, () {});
    });
  });

  ///create Stream for handle is typing & online`
  FirebaseFirestore.instance
      .collection('chat')
      .doc('iau9GgGSQ8KxmzK075k5')
      .snapshots()
      .listen((event) {
    var isTypingData = (event.get('is_typing') as Map<String, dynamic>);
    var isOnlineData = (event.get('is_online') as Map<String, dynamic>);
    var lastSecenData = (event.get('last_seen') as Map<String, dynamic>);

    isTypingData.entries.forEach((element) {
      isTyping[element.key] = (element.value as bool);
    });

    isOnlineData.entries.forEach((element) {
      isOnline[element.key] = (element.value as bool);
    });

    lastSecenData.entries.forEach((element) {
      lastSeen[element.key] = (element.value as Timestamp).toDate();
    });

    sureSetState(this, () {});
  });

  await Future.delayed(Duration(seconds: 1));
  updateIsOnline(true);
}

updateIsTyping(String text) async {
    ///check if is Type for current user false then do true
    if (isTyping.entries.firstWhere((element) => element.key == EnumUtil.toStringEnum(widget.usersEnum)).value == false) {
      updateIsTypingInFirebase(true);
    }

    ///check is user typing after 2 second then return other wise return
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (text == messageController.text.trim()) {
        updateIsTypingInFirebase(false);
      }
    });
  }


  updateIsTypingInFirebase(bool value) {
    ///update is typing into firebase
    FirebaseFirestore.instance
        .collection('chat')
        .doc('iau9GgGSQ8KxmzK075k5')
        .update({
      'is_typing': {
        currentUser: value,
        oppositeUSer: false,
      }
    }).then((value) {
      print('Updated');
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateIsOnline(bool value) {
    FirebaseFirestore.instance
        .collection('chat')
        .doc('iau9GgGSQ8KxmzK075k5')
        .update({
      'is_online': {
        currentUser: value,
        oppositeUSer:
            isOnline.entries.firstWhere((e) => e.key == oppositeUSer).value,
      }
    }).then((value) {
      print('Updated IsOnline');
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateLastSecenTime() {
    FirebaseFirestore.instance
        .collection('chat')
        .doc('iau9GgGSQ8KxmzK075k5')
        .update({
      'last_seen': {
        currentUser: Timestamp.now().toDate(),
        oppositeUSer:
            lastSeen.entries.firstWhere((e) => e.key == oppositeUSer).value,
      }
    }).then((value) {
      print('Updated IsOnline');
    }).catchError((error) {
      print(error.toString());
    });
  }

 */
