import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/constants/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: ListView(
          children: [
            // Switch.adaptive(value: _notifications, onChanged: _onNotificationChanged),
            // CupertinoSwitch(
            //     value: _notifications, onChanged: _onNotificationChanged),
            // Switch(value: _notifications, onChanged: _onNotificationChanged),
            // Checkbox(value: _notifications, onChanged: _onNotificationChanged),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
              title: const Text("Mute video"),
              subtitle: const Text("Video will be muted by default."),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              title: const Text("Autoplay"),
              subtitle: const Text("Video will start playing automatically."),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: const Text("Enabled notifications"),
              subtitle: const Text("Enabled notifications"),
            ),
            CheckboxListTile(
              value: false,
              activeColor: Colors.black,
              onChanged: (value) {},
              title: Text("Marketing emails"),
              subtitle: Text("We won't spam you."),
            ),
            // ListTile(
            //   onTap: () => showAboutDialog(
            //     context: context,
            //     applicationVersion: "1.0",
            //     applicationLegalese: "All rights reserved. Please dont copy me.",
            //   ),
            //   title: const Text(
            //     "About",
            //     style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   subtitle: const Text("About this app....."),
            // ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }

                final booking = await showDateRangePicker(
                  builder: (context, child) {
                    return Theme(
                      child: child!,
                      data: ThemeData(
                        appBarTheme: AppBarTheme(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    );
                  },
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: Text("What is your birthday?"),
            ),
            ListTile(
              title: Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("Plx dont go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          ref.read(authRepo).signOut();
                          context.go("/");
                        },
                        isDestructiveAction: true,
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Log out (Android)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: FaIcon(
                      FontAwesomeIcons.skull,
                    ),
                    title: Text("Are you sure?"),
                    content: Text("Plx dont go"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: FaIcon(FontAwesomeIcons.car),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Log out (iOS / Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    message: Text("Please doooont gooooo"),
                    title: Text("Are you sure?"),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Yes plz"),
                        isDestructiveAction: true,
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(
              applicationVersion: "1.0",
              applicationLegalese: "Don't copy me.",
            ),
          ],
        )
        // CircularProgressIndicator.adaptive(), //플랫폼별로 다른 로딩디자인
        // ListWheelScrollView(
        //   itemExtent: 200,
        //   diameterRatio: 2,
        //   offAxisFraction: 1,
        //   children: [
        //     for (var x in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
        //       FractionallySizedBox(
        //         widthFactor: 1,
        //         child: Container(
        //           child: Text('Pick me'),
        //           color: Colors.teal,
        //           alignment: Alignment.center,
        //         ),
        //       ),
        //   ],
        // ),
        // Column(
        //   children: [
        //     CloseButton(),
        //   ],
        // ),
        );
  }
}
