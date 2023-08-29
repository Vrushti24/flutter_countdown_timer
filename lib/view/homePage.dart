import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../modal/timeValue.dart';

class HomePage extends GetView<TimeController> {
  HomePage({Key? key}) : super(key: key);
  final TimeController timeController = Get.put(TimeController());
  final List<TextEditingController> textController = [];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Center(
            child: Text(
              'Count-Down Timer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: timeController.timers.length,
                itemBuilder: ((context, index) {
                  return _buildTimerCard(timeController.timers[index], index);
                }),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final TextEditingController controller =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Add Timer'),
                        content: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter seconds',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              int seconds = int.parse(controller.text);
                              timeController.addTimer(seconds);

                              controller.clear();
                              Navigator.pop(context);
                            },
                            child: Text('Add'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ));
  }

  //card for showing timer
  _buildTimerCard(TimeValue timeValue, int index) {
    return Card(
      color: const Color.fromARGB(255, 189, 212, 231),
      elevation: 1,
      child: ListTile(
        title: Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Positioned(
                child: _enterTimer(timeValue, index),
              ),
              Positioned(
                left: mq.width * .25,
                top: mq.height * .055,
                child: _viewTimer(timeValue),
              ),
              Positioned(
                left: mq.width * .6,
                top: mq.height * .055,
                child: _button(timeValue),
              ),
              Positioned(
                left: mq.width * .7,
                right: mq.width * .02,
                top: mq.height * .0,
                child: _removeTimer(index),
              ),
              Positioned(
                left: mq.width * .8,
                right: mq.width * .001,
                top: mq.height * .0,
                child: _reset(timeValue),
              )
            ]),
      ),
    );
  }

  //text box for entering time in seconds
  _enterTimer(TimeValue timeValue, int index) {
    if (textController.length <= index) {
      textController.add(TextEditingController());
    }

    TextEditingController controller = textController[index];

    bool isTimerOn = timeValue.isRunning.value;
    return Container(
      width: mq.width * .22,
      height: mq.height * .19,
      child: Padding(
        padding: EdgeInsets.only(left: mq.width * .01, top: mq.height * .06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller,
              enabled: !isTimerOn,
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
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.black87),
                      borderRadius: BorderRadius.circular(10))),
              keyboardType: TextInputType.number,
              readOnly: isTimerOn,
            ),
          ],
        ),
      ),
    );
  }

  //to view timer in hh:mm:ss format
  _viewTimer(TimeValue timer) {
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
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )),
        ));
  }

  //button to start and end timer
  _button(TimeValue timer) {
    return Padding(
      padding: EdgeInsets.only(
          left: mq.width * .03, right: mq.width * .01, top: mq.height * .005),
      child: Container(
        width: mq.width * .25,
        height: mq.height * .075,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2),
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
          child: Obx(() => Text(timer.isRunning.value ? 'Pause' : 'Start')),
        ),
      ),
    );
  }

  _removeTimer(index) {
    return Padding(
      padding: EdgeInsets.only(top: mq.height * .01, left: mq.width * .00003),
      child: IconButton(
          onPressed: () {
            timeController.removeTimer(index);
          },
          icon: Icon(Icons.delete)),
    );
  }

  _reset(TimeValue timeValue) {
    return Padding(
      padding: EdgeInsets.only(top: mq.height * .01, left: mq.width * .00003),
      child: IconButton(
          onPressed: () {
            timeController.resetTimer(timeValue);
          },
          icon: Icon(Icons.restore)),
    );
  }
}
