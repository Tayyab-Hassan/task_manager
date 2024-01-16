import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:task_manager/Models/task.dart';
import 'package:task_manager/Services/themes_services.dart';
import 'package:task_manager/UI/add_task.dart';
import 'package:task_manager/UI/theme.dart';

import '../Controllers/task_controller.dart';
import 'Widgets/appbars.dart';
import 'Widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = Get.put(TaskController());
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets(
        ontap: () {
          ThemeService().switchTheme();
          setState(() {});
        },
      ).appBar(),
      body: Column(
        children: [
          MyWidgets(
            addtask: () async {
              await Get.to(const AddTasks());
              _taskController.getTask();
            },
          ).addTaskBar(),
          MyWidgets(
            selectedDate: date,
          ).addTimeBar(date),
          const SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            // ignore: avoid_print
            print(_taskController.taskList.length);
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                  child: FadeInAnimation(
                      child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      debugPrint('Tapped');
                      _showBottomSheet(
                          context, _taskController.taskList[index]);
                    },
                    child: TaskTile(
                      task: _taskController.taskList[index],
                    ),
                  )
                ],
              ))),
            );
          });
    }));
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(Container(
      padding: const EdgeInsets.only(
        top: 4,
      ),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkgreyclr : Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[200] : Colors.grey[700],
            ),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  lable: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: bluishclr,
                  context: context),
          _bottomSheetButton(
              lable: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              clr: Colors.red[300]!,
              context: context),
          const SizedBox(
            height: 20,
          ),
          _bottomSheetButton(
              lable: "Close",
              onTap: () {
                Get.back();
              },
              clr: Colors.red[300]!,
              isClose: true,
              context: context),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    ));
  }

  _bottomSheetButton(
      {required String lable,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: isClose == true ? Colors.transparent : clr,
            border: Border.all(
              width: 2,
              color: isClose == true
                  ? Get.isDarkMode
                      ? Colors.grey[200]!
                      : Colors.grey[700]!
                  : clr,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          lable,
          style:
              isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
