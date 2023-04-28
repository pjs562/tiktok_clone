import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/constants/features/videos/models/video_model.dart';
import 'package:tiktok_clone/constants/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo({
    required File video,
    required String title,
    required String description,
    required BuildContext context,
  }) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(
          video,
          user!.uid,
        );
        if (task.metadata != null) {
          await _repository.saveVideo(
            VideoModel(
              id: "",
                description: description,
                fileUrl: await task.ref.getDownloadURL(),
                thumbnailUrl: "",
                creatorUid: user.uid,
                likes: 0,
                creator: userProfile.name,
                comments: 0,
                createdAt: DateTime.now().millisecondsSinceEpoch,
                title: title),
          );
          // context.pushReplacement("/home");
          context.pop();
          context.pop();
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
