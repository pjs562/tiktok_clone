import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('준서'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                foregroundImage: NetworkImage(
                  "https://yt3.ggpht.com/mnzLrvJvPhpqDu3q7bJmEfh4dbIhmimi0ZHU5yxK6GuBf6bkgSqajNEqSvHuoSkX0fmVNhwY=s88-c-k-c0x00ffffff-no-rj-mo",
                ),
                child: Text("니꼬"),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "@catheart",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: Sizes.size18,
                    ),
                  ),
                  Gaps.h5,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size16,
                    color: Colors.blue.shade500,
                  )
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserCount(
                      number: "37",
                      text: "Following",
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade200,
                      indent: Sizes.size14,
                      endIndent: Sizes.size14,
                    ),
                    UserCount(
                      number: "10.5M",
                      text: "Followers",
                    ),
                    VerticalDivider(
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade200,
                      indent: Sizes.size14,
                      endIndent: Sizes.size14,
                    ),
                    UserCount(
                      number: "149.3M",
                      text: "Likes",
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class UserCount extends StatelessWidget {
  const UserCount({
    super.key,
    required this.number,
    required this.text,
  });

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
