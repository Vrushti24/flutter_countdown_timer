import 'package:flutter/material.dart';
import '../modal/timeValue.dart';

editBox(
  TimeValue timeValue,
  TextEditingController textController,
) {
  return TextField(
    controller: textController,
    onChanged: (value) {
      int seconds = int.tryParse(value) ?? 0;
      timeValue.currentSeconds.value = seconds;
    },
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 3, color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: 'sec',
      labelStyle: TextStyle(color: Colors.black87),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(width: 2.5, color: Colors.black87),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.black87, fontSize: 18),
  );
}
