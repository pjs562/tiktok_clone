import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/constants/features/users/repos/user_repo.dart';

class ChatRoomViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {

  }

}

final chatRoomProvider = AsyncNotifierProvider<ChatRoomViewModel, void>(
  () => ChatRoomViewModel(),
);
