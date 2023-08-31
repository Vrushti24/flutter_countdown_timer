import 'dart:async';

import 'package:get/get.dart';

//modal class
class TimeValue {
  int id;
  int initialSeconds;
  RxInt currentSeconds;
  RxBool isRunning = false.obs;
  RxBool isTimerOn = false.obs;
  RxInt initialEnteredValue = 0.obs;

  Timer? countdownTimer;

  TimeValue({
    required this.id,
    required this.initialSeconds,
    required this.isRunning,
    required this.isTimerOn,
  }) : currentSeconds = initialSeconds.obs;
}
