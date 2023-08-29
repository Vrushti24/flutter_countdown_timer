import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../modal/timeValue.dart';

button(TimeValue timer) {
  final TimeController timeController = Get.find<TimeController>();
  return Padding(
    padding: EdgeInsets.only(
        left: mq.width * .03, right: mq.width * .01, top: mq.height * .005),
    child: Container(
      width: mq.width * .25,
      height: mq.height * .075,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: Color(0xFF000515),
        ),
      ),
      child: MaterialButton(
        onPressed: () {
          if (timer.isRunning.value) {
            timer.isRunning.value = false;
            timer.countdownTimer?.cancel();
          } else {
            timer.isRunning.value = true;
            timeController.startCountdown(timer);
          }
        },
        color: Color(0xFF000515),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.transparent, // Transparent border color
            width: 2,
          ),
        ),
        child: Obx(() => Text(
              timer.isRunning.value ? 'Pause' : 'Start',
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
      ),
    ),
  );
}
