import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/constants/features/authentication/login_screen.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/constants/features/inbox/views/activity_screen.dart';
import 'package:tiktok_clone/constants/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok_clone/constants/features/inbox/views/chats_screen.dart';
import 'package:tiktok_clone/constants/features/inbox/views/create_chat_room_screen.dart';
import 'package:tiktok_clone/constants/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/constants/features/videos/views/video_recording_screen.dart';

import 'constants/features/notifications/notifications_provider.dart';

final routerProvider = Provider((ref){
  ref.watch(authState);

  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state){
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if(!isLoggedIn){
        if(state.subloc != SignUpScreen.routeURL && state.subloc != LoginScreen.routeURL){
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          ref.read(notificationsProvider(context));
          return child;
        },
        routes: [
          GoRoute(
            name: SignUpScreen.routeName,
            path: SignUpScreen.routeURL,
            builder: (context, state) => const SignUpScreen(),
          ),
          GoRoute(
            name: LoginScreen.routeName,
            path: LoginScreen.routeURL,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            name: InterestScreen.routeName,
            path: InterestScreen.routeURL,
            builder: (context, state) => const InterestScreen(),
          ),
          GoRoute(
            path: "/:tab(home|discover|inbox|profile)",
            name: MainNavigationScreen.routeName,
            builder: (context, state) {
              final tab = state.params["tab"]!;
              return MainNavigationScreen(
                tab: tab,
              );
            },
          ),
          GoRoute(
            name: ActivityScreen.routeName,
            path: ActivityScreen.routeURL,
            builder: (context, state) => const ActivityScreen(),
          ),
          GoRoute(
              name: ChatsScreen.routeName,
              path: ChatsScreen.routeURL,
              builder: (context, state) => const ChatsScreen(),
              routes: [
                GoRoute(
                  path: ChatDetailScreen.routeURL,
                  name: ChatDetailScreen.routeName,
                  builder: (context, state) {
                    final id = state.params["chatId"]!;
                    return ChatDetailScreen(
                      chatId: id,
                    );
                  },
                ),
              ]),
          GoRoute(
            path: VideoRecordingScreen.routeURL,
            name: VideoRecordingScreen.routeName,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: Duration(milliseconds: 200),
              child: VideoRecordingScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                final position = Tween(
                  begin: Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: position,
                  child: child,
                );
              },
            ),
          ),
          GoRoute(
            name: CreateChatRoomScreen.routeName,
            path: CreateChatRoomScreen.routeURL,
            builder: (context, state) => const CreateChatRoomScreen(),
          ),
        ],
      )
    ],
  );
});