import 'dart:async';

import 'package:get/get.dart';

//modal class
class TimeValue {
  int id;
  int initialSeconds;
  RxInt currentSeconds;
  RxBool isRunning = false.obs;
  Timer? countdownTimer;

  TimeValue({required this.id, required this.initialSeconds})
      : currentSeconds = initialSeconds.obs;
}
