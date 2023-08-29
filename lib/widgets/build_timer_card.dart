import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/widgets/enter_timer.dart';
import 'package:flutter_countdown_timer/widgets/play_timer.dart';
import 'package:flutter_countdown_timer/widgets/remove_timer.dart';
import 'package:flutter_countdown_timer/widgets/reset_timer.dart';
import 'package:flutter_countdown_timer/widgets/view_timer.dart';

import '../main.dart';
import '../modal/timeValue.dart';

buildTimerCard(TimeValue timeValue, int index,
    List<TextEditingController> textController) {
  TextEditingController controller = textController[index];

  return Card(
    color: const Color.fromARGB(255, 189, 212, 231),
    elevation: 1,
    child: ListTile(
      title: Stack(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Positioned(
              child: enterTimer(timeValue, controller),
            ),
            Positioned(
              left: mq.width * .25,
              top: mq.height * .055,
              child: viewTimer(timeValue),
            ),
            Positioned(
              left: mq.width * .6,
              top: mq.height * .055,
              child: button(timeValue),
            ),
            Positioned(
              left: mq.width * .7,
              right: mq.width * .02,
              top: mq.height * .0,
              child: removeTimer(index),
            ),
            Positioned(
              left: mq.width * .8,
              right: mq.width * .001,
              top: mq.height * .0,
              child: reset(timeValue),
            )
          ]),
    ),
  );
}
