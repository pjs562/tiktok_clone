import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 200);

  final _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh(){
    return Future.delayed(
        const Duration(seconds: 2)
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 70,
      backgroundColor: Colors.black87,
      color: Theme.of(context).primaryColor,
      onRefresh: _onRefresh,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (BuildContext context, int index) =>
            VideoPost(onVideoFinished: _onVideoFinished, index: index),
      ),
    );
  }
}
