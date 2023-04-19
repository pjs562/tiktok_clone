import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

final darkModConfig = ValueNotifier(SchedulerBinding.instance.window.platformBrightness == Brightness.dark);