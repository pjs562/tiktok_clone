import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/features/authentication/email_screen.dart';
import 'package:tiktok_clone/constants/features/authentication/login_screen.dart';
import 'package:tiktok_clone/constants/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/constants/features/authentication/username_screen.dart';
import 'package:tiktok_clone/constants/features/users/user_progfile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL,
          name: UsernameScreen.routeName,
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              name: EmailScreen.routeName,
              path: EmailScreen.routeURL,
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
              },
            ),
          ]
        ),
      ],
    ),
    // GoRoute(
    //   path: LoginScreen.routName,
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   name: "username_screen",
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),
    GoRoute(
        path: "/users/:username",
        builder: (context, state) {
          final username = state.params['username'];
          final tab = state.queryParams["show"];
          return UserProfileScreen(username: username!, tab: tab!);
        }),
  ],
);
