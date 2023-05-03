import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/inbox/models/chat_room_model.dart';

class ChatRoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  Future<void> createChatRoom(ChatRoomModel model) async {
    _db.collection("chat_rooms").doc("${model.personA}000${model.personB}").set({
      "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
      "personA": model.personA,
      "personB": model.personB,
    });
  }
}

final chatRoomRepo = Provider(
  (ref) => ChatRoomRepository(),
);
