import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';
import '../helper/show_toast.dart';

removeTimer(index, BuildContext context) {
  final TimeController timeController = Get.find<TimeController>();
  return IconButton(
      onPressed: () {
        timeController.removeTimer(index);
        ShowToast.showSnackBar(context, 'Timer removed Successfully');
      },
      icon: const Icon(Icons.delete, color: Color.fromARGB(255, 243, 43, 29)));
}
