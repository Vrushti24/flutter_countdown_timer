import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../widgets/build_timer_card.dart';

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
                  final textControllerList = textController.length > index
                      ? textController[index]
                      : TextEditingController();
                  if (textController.length <= index) {
                    textController.add(textControllerList);
                  }
                  return buildTimerCard(
                      timeController.timers[index], index, textController);
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
}
