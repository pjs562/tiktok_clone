import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/inbox/view_models/user_list_view_model.dart';
import 'package:tiktok_clone/constants/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/constants/gaps.dart';

import '../../../sizes.dart';

class CreateChatRoomScreen extends ConsumerStatefulWidget {
  static const String routeName = "createChatRoom";
  static const String routeURL = "/createdChatRoom";

  const CreateChatRoomScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateChatRoomScreen> createState() =>
      _CreateChatRoomScreenState();
}

class _CreateChatRoomScreenState extends ConsumerState<CreateChatRoomScreen> {

  Widget _makeTile(UserProfileModel model) {
    return ListTile(
      onTap: () => {},
      leading: CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
          model.link
        ),
        child: Text(model.name),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            model.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            model.uid,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: const Text("Don't forget to make video"),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact Invitation",
        ),
      ),
      body: ref.watch(userListProvider).when(
        data: (users) => ListView.separated(
          itemBuilder: (context, index){
            return _makeTile(users[index]);
          },
          separatorBuilder: (BuildContext context, int index) => Gaps.v5,
          itemCount: users.length,
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            "Could not load users: $error",
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
