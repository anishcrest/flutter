import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common_components/model/chat_model.dart';
import 'package:common_components/repository/chat_repository.dart';
import 'package:mobx/mobx.dart';

part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final ChatRepository chatRepository;

  _ChatStore(this.chatRepository);

  ///list of Messages
  @observable
  ObservableList<ChatModel> messageList = ObservableList();

  ///handle typing
  @observable
  ObservableMap<String, bool> isTyping = ObservableMap();

  ///handle online
  @observable
  ObservableMap<String, bool> isOnline = ObservableMap();

  ///handle online
  @observable
  ObservableMap<String, DateTime> lastSeen = ObservableMap();

  @observable
  String currentUser = '';

  @observable
  String oppositeUSer = '';

  @action
  fetchChatListBasedOnId() async {
    List<ChatModel> tempList = [];

    ///create Stream for incoming message
    chatRepository.messageStream().listen((event) {
      messageList.clear();

      event.forEach((element) {
        tempList.add(element);

        ///sort by created time
        tempList.sort((a, b) {
          return b.createdAt!.compareTo(a.createdAt!);
        });

        messageList.addAll(tempList);
      });
    });

    ///create Stream for handle is typing & online`
    chatRepository.onlineAndTypingStream().listen((event) {
      var isTypingData = (event.get('is_typing') as Map<String, dynamic>);
      var isOnlineData = (event.get('is_online') as Map<String, dynamic>);
      var lastSeenData = (event.get('last_seen') as Map<String, dynamic>);

      isTypingData.entries.forEach((element) {
        isTyping[element.key] = (element.value as bool);
      });

      isOnlineData.entries.forEach((element) {
        isOnline[element.key] = (element.value as bool);
      });

      lastSeenData.entries.forEach((element) {
        lastSeen[element.key] = (element.value as Timestamp).toDate();
      });

      print('Typing ' + isTyping.toString());
      print('online' + isOnline.toString());
      print('last sece' + lastSeen.toString());
    });

    await Future.delayed(Duration(seconds: 1));
    chatRepository.updateIsOnline(
      value: true,
      currentUser: currentUser,
      oppositeUSer: oppositeUSer,
      oppositeUSerValue: isOnline.entries
          .firstWhere((element) => element.key == oppositeUSer)
          .value,
    );
    //updateIsOnline(true);
  }

  @action
  sendMessage({String? url, String? message}) {
    chatRepository.sendMessage(
      senderId: currentUser,
      receiverId: oppositeUSer,
      url: url,
      message: message,
    );
  }

  updateIsTypingInFirebase(bool value) {
    ///update is typing into firebase
    chatRepository.updateIsTypingInFirebase(
      value: value,
      currentUser: currentUser,
      oppositeUSer: oppositeUSer,
      oppositeUSerValue: false,
    );
  }

  updateIsOnline(bool value) {
    chatRepository.updateIsOnline(
      value: value,
      currentUser: currentUser,
      oppositeUSer: oppositeUSer,
      oppositeUSerValue:
          isOnline.entries.firstWhere((e) => e.key == oppositeUSer).value,
    );
  }

  updateLastSeenTime() {
    chatRepository.updateLastSeenTime(
      currentUser: currentUser,
      oppositeUSer: oppositeUSer,
      oppositeUSerTime:
          lastSeen.entries.firstWhere((e) => e.key == oppositeUSer).value,
    );
  }
}
