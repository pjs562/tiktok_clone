import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/features/settings/settings_screen.dart';
import 'package:tiktok_clone/constants/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/constants/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/constants/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    Key? key,
    required this.username,
    required this.tab,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 4,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: "assets/images/placeholder.jpg",
                                image:
                                    "https://images.unsplash.com/photo-1649844232985-6daab6b19778?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3264&q=80",
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 10,
                              child: Row(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: Sizes.size14,
                                  ),
                                  Gaps.h10,
                                  Text(
                                    "4.1M",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) => Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 3 / 4,
                              child: FadeInImage.assetNetwork(
                                fit: BoxFit.cover,
                                placeholder: "assets/images/placeholder.jpg",
                                image:
                                    "https://images.unsplash.com/photo-1649844232985-6daab6b19778?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3264&q=80",
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 10,
                              child: Row(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.play,
                                    color: Colors.white,
                                    size: Sizes.size14,
                                  ),
                                  Gaps.h10,
                                  Text(
                                    "4.1M",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Sizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.ellipsis,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            Avatar(
                              uid: data.uid,
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${data.name}",
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const UserCount(
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
                                  const UserCount(
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
                                  const UserCount(
                                    number: "149.3M",
                                    text: "Likes",
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size14,
                                    horizontal: Sizes.size52,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size2,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Follow',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gaps.h3,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 9,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size2,
                                      ),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                      width: Sizes.size1,
                                    ),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.youtube,
                                  ),
                                ),
                                Gaps.h3,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 9,
                                    horizontal: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        Sizes.size2,
                                      ),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                      width: Sizes.size1,
                                    ),
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.caretDown,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                "All highlights and where to watch live matches on FIFA+ I wonder how it look",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  "https://github.com/pjs562/tiktok_clone",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                ),
              ),
            ),
          ),
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
