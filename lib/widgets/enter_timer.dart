import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/timeController.dart';
import '../main.dart';
import '../modal/timeValue.dart';
import 'edit_box.dart';

enterTimer(TimeValue timeValue, TextEditingController textController,
    RxBool isTimerOn) {
  return Container(
    width: mq.width * .22,
    height: mq.height * .19,
    child: Padding(
      padding: EdgeInsets.only(left: mq.width * .01, top: mq.height * .06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() {
            final bool isTimerRunning = timeValue.isRunning.value;
            final bool isEditingEnabled =
                (!isTimerRunning && timeValue.initialSeconds == 0) ||
                    (!isTimerRunning && !timeValue.isTimerOn.value) ||
                    (!isTimerRunning && timeValue.initialSeconds != 0);

            if (isEditingEnabled) {
              return TextFormField(
                controller: textController,
                onChanged: (value) {
                  if (!isTimerRunning) {
                    if (value.isEmpty) {
                      timeValue.currentSeconds.value = 0;
                    } else {
                      int seconds = int.tryParse(value) ?? 0;
                      timeValue.currentSeconds.value = seconds;
                      timeValue.initialSeconds = seconds;
                    }
                  }
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: Colors.black87),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'sec',
                  labelStyle: TextStyle(color: Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2.5, color: Colors.black87),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
                readOnly: isTimerRunning || !isEditingEnabled,
                style: TextStyle(color: Colors.black87, fontSize: 18),
              );
            } else if (timeValue.currentSeconds.value == 0) {
              textController.text = '';
              return editBox(timeValue, textController);
            } else {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: mq.width * .2,
                  height: mq.height * .075,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 144, 140, 140),
                      border: Border.all(width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      '${timeValue.initialSeconds}',
                      style: TextStyle(color: Colors.black26),
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    ),
  );
}
