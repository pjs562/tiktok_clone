import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({Key? key}) : super(key: key);

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onClosedPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: const Text("22796 comments"),
          actions: [
            IconButton(
              onPressed: _onClosedPressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size16,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: Text("준서"),
                  ),
                  Gaps.h10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '니꼬',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Sizes.size14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                            "That's not it I've seen the same thing but also in a cave"),
                      ],
                    ),
                  ),
                  Gaps.h10,
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.grey.shade500,
                        size: Sizes.size20,
                      ),
                      Gaps.v2,
                      Text(
                        "52.5K",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ],
              ),
              separatorBuilder: (BuildContext context, int index) => Gaps.v20,
            ),
            Positioned(
              bottom: 0,
              width: size.width,
              child: BottomAppBar(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size16,
                    vertical: Sizes.size10,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        child: Text("준서"),
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                      ),
                      Gaps.h10,
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Write a comment...",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size12,
                              vertical: Sizes.size10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
