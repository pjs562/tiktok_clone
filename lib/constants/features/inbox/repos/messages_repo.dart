import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/inbox/models/message.dart';

class MessagesRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message, String chatRoomId) async {
    await _db.collection("chat_rooms").doc(chatRoomId).collection("texts").add(
          message.toJson(),
        );
  }
}

final messagesRepo = Provider((ref) => MessagesRepo());
