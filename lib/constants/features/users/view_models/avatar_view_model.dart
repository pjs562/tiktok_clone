import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/users/view_models/users_view_model.dart';

import '../repos/user_repo.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = AsyncValue.loading();
    final fileName = ref
        .read(authRepo)
        .user!
        .uid;
    _repository.uploadAvatar(file, fileName);
    state = await AsyncValue.guard(
          () async {
        await _repository.uploadAvatar(file, fileName);
        ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
      () => AvatarViewModel(),
);
