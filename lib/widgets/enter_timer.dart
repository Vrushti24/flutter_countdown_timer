import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../modal/timeValue.dart';

enterTimer(TimeValue timeValue, TextEditingController textController,
    RxBool isTimerOn) {
  //RxBool isTimerOn = timeValue.isRunning;
  return Container(
    width: mq.width * .22,
    height: mq.height * .19,
    child: Padding(
      padding: EdgeInsets.only(left: mq.width * .01, top: mq.height * .06),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormField(
            controller: textController,
            enabled: !isTimerOn.value,
            onChanged: ((value) {
              int seconds = int.parse(value);
              timeValue.currentSeconds.value = seconds;
              //controller.clear();
            }),
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: Colors.black87),
                    borderRadius: BorderRadius.circular(10)),
                labelText: 'sec',
                labelStyle: TextStyle(color: Colors.black87),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2.5, color: Colors.black87),
                    borderRadius: BorderRadius.circular(10))),
            keyboardType: TextInputType.number,
            readOnly: isTimerOn.value,
          ),
        ],
      ),
    ),
  );
}
