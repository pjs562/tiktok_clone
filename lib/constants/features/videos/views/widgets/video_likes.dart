import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok_clone/constants/features/videos/views/widgets/video_button.dart';

class VideoLikes extends ConsumerWidget {
  final int likes;
  final String videoId;

  const VideoLikes({
    Key? key,
    required this.likes,
    required this.videoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(videoPostProvider(videoId)).when(
          data: (data) {
            return GestureDetector(
              onTap: () => ref.read(videoPostProvider(videoId).notifier).toggleVideolike(),
              child: VideoButton(
                icon: FontAwesomeIcons.solidHeart,
                text:  "${data.likeCount}",
                isCliked: data.isLikeVideo,
              ),
            );
          },
          error: (error, stackTrace) => const SizedBox(),
          loading: () => VideoButton(
            icon: FontAwesomeIcons.solidHeart,
            text: "$likes",
          ),
        );
  }
}
