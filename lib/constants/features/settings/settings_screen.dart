import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              value: _notifications,
              onChanged: _onNotificationChanged,
              title: const Text("Enabled notifications"),
              subtitle: const Text("Enabled notifications"),
            ),
            CheckboxListTile(
              value: _notifications,
              activeColor: Colors.black,
              onChanged: _onNotificationChanged,
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
                if(! mounted) return;
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
                if(! mounted) return;
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
                        onPressed: () => Navigator.of(context).pop(),
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
