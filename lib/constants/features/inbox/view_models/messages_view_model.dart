import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/inbox/models/message.dart';
import 'package:tiktok_clone/constants/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepo _repo;

  @override
  FutureOr<void> build() {
    _repo = ref.read(messagesRepo);
  }

  Future<void> sendMessages(String text) async {
    final user = ref.read(authRepo).user;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _repo.sendMessage(message, "9bdLqzsYUvTDF55cSwDx");
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

//autoDispose를 해주지 않으면 화면을 나가든 안나가든 StreamProvider가 계속 살아 있다. auto dispose를 하면 사용자가 채팅방을 나갔을 때 자동으로 Firebase에 변경사항 생기는걸 그만 listen한다.
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("chat_rooms")
      .doc("9bdLqzsYUvTDF55cSwDx")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList().reversed.toList(),
      );
});
