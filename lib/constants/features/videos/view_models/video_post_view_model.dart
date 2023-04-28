import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/videos/models/video_like_model.dart';
import 'package:tiktok_clone/constants/features/videos/repos/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<VideoLikeModel, String> {

  late final VideosRepository _repository;
  late final _videoId;
  bool _isLiked = false;
  int _likeCounts = 0;
  @override
  FutureOr<VideoLikeModel> build(String videoId) async{
    _videoId = videoId;
    _repository = ref.read(videosRepo);
    return isLiked();
  }

  Future<void> toggleVideolike() async {
    final user = ref.read(authRepo).user;
    final isLiked = await _repository.toggleVideoLike(_videoId, user!.uid);
    _isLiked = !isLiked;
    _likeCounts = isLiked? _likeCounts - 1 : _likeCounts + 1;
    state = AsyncValue.data(VideoLikeModel(isLikeVideo: _isLiked, likeCount: _likeCounts));
  }

  Future<VideoLikeModel> isLiked() async {
    final user = ref.read(authRepo).user;
    final videoLikeModel = await _repository.isLiked(_videoId, user!.uid);
    _isLiked = videoLikeModel.isLikeVideo;
    _likeCounts = videoLikeModel.likeCount;
    return videoLikeModel;
  }
}

final videoPostProvider = AsyncNotifierProvider.family<VideoPostViewModel, VideoLikeModel, String>(
  () => VideoPostViewModel(),
);
