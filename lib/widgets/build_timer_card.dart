import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:flutter_countdown_timer/widgets/enter_timer.dart';
import 'package:flutter_countdown_timer/widgets/play_timer.dart';
import 'package:flutter_countdown_timer/widgets/remove_timer.dart';
import 'package:flutter_countdown_timer/widgets/reset_timer.dart';
import 'package:flutter_countdown_timer/widgets/view_timer.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../modal/timeValue.dart';

//card
Widget buildTimerCard(TimeValue timeValue, int index, BuildContext context) {
  final TimeController timeController = Get.find<TimeController>();
  TextEditingController controller = timeController.textController[index];

  return Card(
    color: Color.fromARGB(
        255, 162, 244, 244), // Change the card color to a light shade
    elevation: 5, // Add a slight elevation to the card
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners
      side: BorderSide(color: Colors.blueGrey, width: 1), // Border
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0), // Add some padding
      child: ListTile(
        title: Stack(
          children: [
            Positioned(
              //left: mq.width * .01,

              child: enterTimer(timeValue, controller, timeValue.isRunning),
            ),
            Positioned(
              left: mq.width * .23,
              top: mq.height * .055,
              child: viewTimer(timeValue),
            ),
            Positioned(
              left: mq.width * .55,
              top: mq.height * .055,
              child: button(timeValue),
            ),
            Positioned(
              left: mq.width * .6,
              right: mq.width * .01,
              top: mq.height * .0,
              child: removeTimer(index, context),
            ),
            Positioned(
              left: mq.width * .80,
              right: mq.width * .01,
              top: mq.height * .0,
              child: reset(timeValue, context),
            ),
          ],
        ),
      ),
    ),
  );
}
