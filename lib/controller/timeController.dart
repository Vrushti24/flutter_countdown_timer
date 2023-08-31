import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/timeValue.dart';

class TimeController extends GetxController {
  RxList<TimeValue> timers = <TimeValue>[].obs;
  List<TextEditingController> textController = [];

  //adding timer to display on screen(card)
  void addTimer(int seconds) {
    final textControl = TextEditingController(text: seconds.toString());
    textController.add(textControl);

    timers.add(TimeValue(
        id: timers.length,
        initialSeconds: seconds,
        isRunning: false.obs,
        isTimerOn: false.obs));
  }

  //to delete the timer card
  void removeTimer(int index) {
    textController[index].dispose();
    textController.removeAt(index);
    timers.removeAt(index);
  }

  //to reset the timer card
  void resetTimer(TimeValue timeValue) {
    timeValue.currentSeconds.value = 0;
    timeValue.initialSeconds = 0;
    timeValue.isRunning.value = false;
    timeValue.initialEnteredValue.value = 0;
    timeValue.countdownTimer?.cancel();
  }

  //formatting seconds to DD:HH:MM:SS
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

  //to start the timer
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
