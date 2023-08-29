import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../modal/timeValue.dart';

viewTimer(TimeValue timer) {
  final TimeController timeController = Get.find<TimeController>();
  return Padding(
      padding: EdgeInsets.only(left: mq.width * .03, top: mq.height * .005),
      child: Container(
        width: mq.width * .3,
        height: mq.height * .075,
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Obx(() => Center(
              child: Text(
                timeController.formatDuration(
                    Duration(seconds: timer.currentSeconds.value)),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87),
              ),
            )),
      ));
}
