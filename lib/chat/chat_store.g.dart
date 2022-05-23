// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStore, Store {
  final _$messageListAtom = Atom(name: '_ChatStore.messageList');

  @override
  ObservableList<ChatModel> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(ObservableList<ChatModel> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  final _$isTypingAtom = Atom(name: '_ChatStore.isTyping');

  @override
  ObservableMap<String, bool> get isTyping {
    _$isTypingAtom.reportRead();
    return super.isTyping;
  }

  @override
  set isTyping(ObservableMap<String, bool> value) {
    _$isTypingAtom.reportWrite(value, super.isTyping, () {
      super.isTyping = value;
    });
  }

  final _$isOnlineAtom = Atom(name: '_ChatStore.isOnline');

  @override
  ObservableMap<String, bool> get isOnline {
    _$isOnlineAtom.reportRead();
    return super.isOnline;
  }

  @override
  set isOnline(ObservableMap<String, bool> value) {
    _$isOnlineAtom.reportWrite(value, super.isOnline, () {
      super.isOnline = value;
    });
  }

  final _$lastSeenAtom = Atom(name: '_ChatStore.lastSeen');

  @override
  ObservableMap<String, DateTime> get lastSeen {
    _$lastSeenAtom.reportRead();
    return super.lastSeen;
  }

  @override
  set lastSeen(ObservableMap<String, DateTime> value) {
    _$lastSeenAtom.reportWrite(value, super.lastSeen, () {
      super.lastSeen = value;
    });
  }

  final _$currentUserAtom = Atom(name: '_ChatStore.currentUser');

  @override
  String get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(String value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$oppositeUSerAtom = Atom(name: '_ChatStore.oppositeUSer');

  @override
  String get oppositeUSer {
    _$oppositeUSerAtom.reportRead();
    return super.oppositeUSer;
  }

  @override
  set oppositeUSer(String value) {
    _$oppositeUSerAtom.reportWrite(value, super.oppositeUSer, () {
      super.oppositeUSer = value;
    });
  }

  final _$fetchChatListBasedOnIdAsyncAction =
      AsyncAction('_ChatStore.fetchChatListBasedOnId');

  @override
  Future fetchChatListBasedOnId() {
    return _$fetchChatListBasedOnIdAsyncAction
        .run(() => super.fetchChatListBasedOnId());
  }

  final _$_ChatStoreActionController = ActionController(name: '_ChatStore');

  @override
  dynamic sendMessage({String? url, String? message}) {
    final _$actionInfo = _$_ChatStoreActionController.startAction(
        name: '_ChatStore.sendMessage');
    try {
      return super.sendMessage(url: url, message: message);
    } finally {
      _$_ChatStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageList: ${messageList},
isTyping: ${isTyping},
isOnline: ${isOnline},
lastSeen: ${lastSeen},
currentUser: ${currentUser},
oppositeUSer: ${oppositeUSer}
    ''';
  }
}
