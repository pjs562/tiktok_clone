import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/common/widgets/video_configuration/video_config.dart';
import 'package:tiktok_clone/constants/features/videos/widgets/ExpandableText.dart';
import 'package:tiktok_clone/constants/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/constants/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../generated/l10n.dart';
import '../../../sizes.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
  }) : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");

  bool _isPaused = false;
  bool _autoMute = videoConfig.value;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb || _autoMute) {
      await _videoPlayerController.setVolume(0);
    }

    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    
    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.value;
        _videoPlayerController.setVolume(_autoMute ? 0 : 100);
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(child: GestureDetector(onTap: _onTogglePause)),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: _isPaused
                        ? const FaIcon(
                            FontAwesomeIcons.pause,
                            color: Colors.white,
                            size: Sizes.size52,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.play,
                            color: Colors.white,
                            size: Sizes.size52,
                          ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "@jspark1349",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.v10,
                Text(
                  "맨날 잠만 자는 하트",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.white,
                  ),
                ),
                Gaps.v5,
                ExpandableText(
                  text:
                      "#고양이 #노르웨이 숲 고양이 #동물짤 #귀여운짤 #좋아요 #좋반#좋테 #맞팔환영 #고양이짤 #존귀",
                  maxLines: 1,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 12,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://yt3.ggpht.com/mnzLrvJvPhpqDu3q7bJmEfh4dbIhmimi0ZHU5yxK6GuBf6bkgSqajNEqSvHuoSkX0fmVNhwY=s88-c-k-c0x00ffffff-no-rj-mo"),
                  child: Text("준서"),
                ),
                Gaps.v20,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(9879879879717),
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(65656),
                  ),
                ),
                Gaps.v20,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: (){videoConfig.value = !videoConfig.value;},
                  child: VideoButton(
                    icon: _autoMute
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    text: "Volume",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
