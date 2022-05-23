import 'package:common_components/utils/enum_utils.dart';

class MessageModel {
  final MessageType messageType;
  final String? imageUrl;
  final String? content;

  MessageModel({
    this.messageType = MessageType.text,
    this.content,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'messageType': EnumUtil.toStringEnum(messageType),
      'content': content != null ? content : null,
      'imageUrl': imageUrl != null ? imageUrl : null,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageType:
          EnumUtil.fromStringEnum(MessageType.values, map['messageType']),
      content: map['content'] != null ? map['content'] : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] : null,
    );
  }
}
