import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_components/model/message_model.dart';

class ChatModel {
  final MessageModel messageModel;
  final String senderId;
  final String receiverId;
  final DateTime? createdAt;

  ChatModel({
    required this.messageModel,
    required this.senderId,
    required this.receiverId,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': messageModel.toMap(),
      'senderId': senderId,
      'receiverId': receiverId,
      'createdAt': Timestamp.now(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      messageModel: MessageModel.fromMap(map['message']),
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
