import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../modal/timeValue.dart';

reset(TimeValue timeValue) {
  final TimeController timeController = Get.find<TimeController>();
  return Padding(
    padding: EdgeInsets.only(top: mq.height * .01, left: mq.width * .00003),
    child: IconButton(
        onPressed: () {
          timeController.resetTimer(timeValue);
        },
        icon: Icon(Icons.restore)),
  );
}
