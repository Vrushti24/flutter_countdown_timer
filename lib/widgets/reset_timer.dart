import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';

import '../helper/show_toast.dart';
import '../modal/timeValue.dart';

reset(TimeValue timeValue, BuildContext context) {
  final TimeController timeController = Get.find<TimeController>();
  return IconButton(
      onPressed: () {
        timeController.resetTimer(timeValue);
        timeValue.isRunning.value = false;
        ShowToast.showSnackBar(context, 'Timer reset Successful');
      },
      icon: const Icon(
        Icons.restart_alt,
        color: Colors.black87,
      ));
}
