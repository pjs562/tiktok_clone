import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/features/authentication/username_screen.dart';
import 'package:tiktok_clone/constants/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/constants/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import '../../../common/widgets/dark_mode_configuration/dark_mode_config.dart';
import '../../../generated/l10n.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerWidget {
  static const routeURL = "/";
  static const routeName = "signUp";

  const SignUpScreen({Key? key}) : super(key: key);

  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle("TikTok"),
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    S.of(context).signUpSubtitle(3),
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: darkModConfig.value
                          ? Colors.grey.shade300
                          : Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                        onPressed: _onEmailTap,
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: S.of(context).emailPasswordButton),
                    Gaps.v16,
                    AuthButton(
                        onPressed: (context) => ref
                            .read(socialAuthProvider.notifier)
                            .githubSignIn(context),
                        icon: const FaIcon(FontAwesomeIcons.github),
                        text: "Continue with Github"),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                              onPressed: _onEmailTap,
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: S.of(context).emailPasswordButton),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: AuthButton(
                              onPressed: _onEmailTap,
                              icon: const FaIcon(FontAwesomeIcons.apple),
                              text: S.of(context).appleButton),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: darkModConfig.value ? null : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
