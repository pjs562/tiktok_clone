import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/features/users/models/user_profile_model.dart';

import '../../users/repos/user_repo.dart';

class UserListViewModel extends AsyncNotifier<List<UserProfileModel>>{
  @override
  FutureOr<List<UserProfileModel>> build() {
    return getUsers();
  }

  Future<List<UserProfileModel>> getUsers() async {
    final result = await ref.read(userRepo).fetchUser();
    final users = result.docs.map((doc) => UserProfileModel.fromJson(doc.data()));
    return users.toList();
  }
}

final userListProvider = AsyncNotifierProvider<UserListViewModel, List<UserProfileModel>>(
    () => UserListViewModel(),
);