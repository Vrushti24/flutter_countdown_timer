import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/controller/timeController.dart';
import 'package:flutter_countdown_timer/helper/show_toast.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../widgets/build_timer_card.dart';

class HomePage extends GetView<TimeController> {
  HomePage({Key? key}) : super(key: key);

  ///This allows you to easily access and use the TimeController
  final TimeController timeController = Get.put(TimeController());
  final List<TextEditingController> textController = [];

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFF000515),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 35, 25, 32),
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
                  //to ensure that each item in a list has its own dedicated TextEditingController instance.
                  final textControllerList = textController.length > index
                      ? textController[index]
                      : TextEditingController();
                  if (textController.length <= index) {
                    textController.add(textControllerList);
                  }
                  return buildTimerCard(timeController.timers[index], index,
                      textController, context);
                }),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: mq.height * .07,
                  width: mq.width * .3,
                  child: MaterialButton(
                    elevation: 3,
                    color: const Color.fromARGB(255, 232, 180, 241),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController controller =
                              TextEditingController();
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 242, 209, 248),
                            title: const Text(
                              'Add Timer',
                              style: TextStyle(color: Colors.black87),
                            ),
                            content: TextField(
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Enter seconds',
                                  hintStyle: TextStyle(color: Colors.black87)),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 18),
                            ),
                            actions: [
                              Container(
                                color: const Color.fromARGB(255, 187, 74, 66),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.black87,
                                child: MaterialButton(
                                  onPressed: () {
                                    String input = controller.text.trim();

                                    if (input.isEmpty) {
                                      Navigator.pop(context);
                                      ShowToast.showSnackBar(
                                          context, 'Please add seconds');
                                    } else {
                                      int seconds = int.parse(input);
                                      if (seconds == 0) {
                                        Navigator.pop(context);
                                        ShowToast.showSnackBar(context,
                                            'Please add non-zero seconds ');
                                      } else {
                                        timeController.addTimer(seconds);
                                        controller.clear();
                                        Navigator.pop(context);
                                        ShowToast.showSnackBar(context,
                                            'Timer added successfully');
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'Add',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add Timer'),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
