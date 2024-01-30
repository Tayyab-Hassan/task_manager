// ignore_for_file: avoid_print

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Models/task.dart';
import 'package:task_manager/Services/themes_services.dart';
import 'package:task_manager/UI/Widgets/button.dart';
import 'package:task_manager/UI/add_task.dart';
import 'package:task_manager/UI/theme.dart';

import '../Controllers/task_controller.dart';
import '../Services/notification_services.dart';
import 'Widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var notifyHlper;
  final TaskController _taskController = Get.put(TaskController());
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    notifyHlper = NotifyHelper();
    NotifyHelper().initializeNotification();
    NotifyHelper().requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          addTaskBar(),
          addTimeBar(selectedDate),
          const SizedBox(
            height: 10,
          ),
          _showTasks(),
        ],
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                print("StartTime:  ${task.startTime}\n");
                DateTime cdate = DateTime.now();
                print(" :$cdate\n");
                DateTime date =
                    DateFormat('hh:mm').parse(task.startTime.toString());
                print("2nd Time :$date\n");
                date = DateTime(
                    cdate.year, cdate.month, cdate.day, date.hour, date.minute);
                print("3rd Time :$date\n");
                var mytime = DateFormat('hh:mm').format(date);
                notifyHlper.scheduledNotification(
                    int.parse(mytime.toString().split(":")[0]),
                    int.parse(mytime.toString().split(":")[1]),
                    task);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              debugPrint('Tapped');
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(
                              task: task,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              debugPrint('Tapped');
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(
                              task: task,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
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

  addTimeBar(DateTime dateTime) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryclr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600)),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w600)),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w600)),
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }

  addTaskBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text('ToDay', style: headingStyle)
            ],
          ),
          MyButton(
            lable: "+ Add Task",
            onTap: () async {
              await Get.to(const AddTasks());
              _taskController.getTask();
            },
          )
        ],
      ),
    );
  }

  appBar() {
    return AppBar(
      title: const Text(
        "TASK MANAGER",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            ThemeService().switchTheme();
          });
          notifyHlper.displayNotification(
            title: "Theme Changed",
            body: Get.isDarkMode
                ? "Activated Light Theme"
                : "Activated Dark Theme",
          );
        },
        child: Get.isDarkMode != false
            ? Icon(
                Icons.nightlight_round_outlined,
                color: Get.isDarkMode ? Colors.black : Colors.white,
              )
            : Icon(
                Icons.sunny,
                color: Colors.grey[200],
              ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage("images/a.jpg"),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
