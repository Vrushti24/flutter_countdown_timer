import 'dart:async';

import 'package:get/get.dart';

import '../modal/timeValue.dart';

class TimeController extends GetxController {
  RxList<TimeValue> timers = <TimeValue>[].obs;

  void addTimer(int seconds) {
    timers.add(TimeValue(id: timers.length, initialSeconds: seconds));
  }

  void removeTimer(int index) {
    timers.removeAt(index);
  }

  void resetTimer(TimeValue timeValue) {
    timeValue.currentSeconds.value = 0;
    timeValue.initialSeconds = 0;
    timeValue.isRunning.value = false;
    timeValue.countdownTimer?.cancel();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String days = twoDigits(duration.inDays);
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    if (days != '00') {
      return "$days:$hours:$minutes:$seconds";
    } else {
      return "$hours:$minutes:$seconds";
    }
  }

  void startCountdown(TimeValue timeValue) {
    timeValue.countdownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!timeValue.isRunning.value) {
        t.cancel();
        return;
      }

      if (timeValue.currentSeconds.value > 0) {
        timeValue.currentSeconds.value--;
      } else {
        timeValue.isRunning.value = false;
        timeValue.countdownTimer?.cancel();
      }
    });
  }
}
