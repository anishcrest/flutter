import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_components/model/chat_model.dart';
import 'package:common_components/model/message_model.dart';
import 'package:common_components/utils/constant_utils.dart';
import 'package:common_components/utils/enum_utils.dart';

class ChatRepository {
  Stream<Iterable<ChatModel>> messageStream() {
    return FirebaseFirestore.instance
        .collection(ConstantUtil.chat_collection)
        .doc(ConstantUtil.chat_document)
        .collection(ConstantUtil.chat_list_collection)
        .snapshots()
        .map((event) => event.docs.map((e) => ChatModel.fromMap(e.data())));
  }

  Stream<DocumentSnapshot> onlineAndTypingStream() {
    return FirebaseFirestore.instance
        .collection(ConstantUtil.chat_collection)
        .doc(ConstantUtil.chat_document)
        .snapshots();
  }

  sendMessage(
      {String? url,
      String? message,
      required String senderId,
      required String receiverId}) {
    try {
      MessageModel messageModel = MessageModel(
        content: message,
        messageType: MessageType.text,
        imageUrl: url,
      );

      ChatModel chatModel = ChatModel(
        messageModel: messageModel,
        senderId: senderId,
        receiverId: receiverId,
      );

      ///store data into firebase
      FirebaseFirestore.instance
          .collection(ConstantUtil.chat_collection)
          .doc(ConstantUtil.chat_document)
          .collection(ConstantUtil.chat_list_collection)
          .add(chatModel.toMap())
          .then((value) {
        print(value.id);
      }).catchError((error) {
        print(error.toString());
      });
    } catch (e) {}
  }

  updateLastSeenTime(
      {required String currentUser,
      required String oppositeUSer,
      required DateTime oppositeUSerTime}) {
    FirebaseFirestore.instance
        .collection(ConstantUtil.chat_collection)
        .doc(ConstantUtil.chat_document)
        .update({
      'last_seen': {
        currentUser: Timestamp.now().toDate(),
        oppositeUSer: oppositeUSerTime,
      }
    }).then((value) {
      print('Updated IsOnline');
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateIsOnline(
      {required bool value,
      required String currentUser,
      required String oppositeUSer,
      required bool oppositeUSerValue}) {
    FirebaseFirestore.instance
        .collection(ConstantUtil.chat_collection)
        .doc(ConstantUtil.chat_document)
        .update({
      'is_online': {
        currentUser: value,
        oppositeUSer: oppositeUSerValue,
      }
    }).then((value) {
      print('Updated IsOnline');
    }).catchError((error) {
      print(error.toString());
    });
  }

  updateIsTypingInFirebase(
      {required bool value,
      required String currentUser,
      required String oppositeUSer,
      required bool oppositeUSerValue}) {
    ///update is typing into firebase
    FirebaseFirestore.instance
        .collection(ConstantUtil.chat_collection)
        .doc(ConstantUtil.chat_document)
        .update({
      'is_typing': {
        currentUser: value,
        oppositeUSer: oppositeUSerValue,
      }
    }).then((value) {
      print('Updated');
    }).catchError((error) {
      print(error.toString());
    });
  }
}
