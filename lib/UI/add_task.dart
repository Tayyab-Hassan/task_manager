import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/Controllers/task_controller.dart';
import 'package:task_manager/Models/task.dart';
import 'package:task_manager/UI/Widgets/button.dart';
import 'package:task_manager/UI/Widgets/input_field.dart';
import 'package:task_manager/UI/theme.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final TaskController _taskController = Get.put(TaskController());
  TextEditingController titleController = TextEditingController();
  TextEditingController discrptionController = TextEditingController();
  // ignore: unnecessary_nullable_for_final_variable_declarations
  late DateTime _selectedDate = DateTime.now();
  late String _endDate = "9:30 PM";
  late String _startDate =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  late int _selectedRemind = 5;
  late String _selectedRepeat = "None";
  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];
  late int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("images/a.jpg"),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                "Add Task",
                style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              MyInputField(
                hint: 'Enter Title here',
                title: "Title",
                controller: titleController,
              ),
              MyInputField(
                hint: 'Enter Discription here',
                title: "Discription",
                controller: discrptionController,
              ),
              MyInputField(
                hint: DateFormat.yMd().format(_selectedDate),
                title: "Date",
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_month_outlined,
                    color: Get.isDarkMode ? Colors.white : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      getDateFromUser();
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      hint: _startDate,
                      title: "Start Date",
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Get.isDarkMode ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyInputField(
                      hint: _endDate,
                      title: "End Date",
                      widget: IconButton(
                        onPressed: () {
                          getTimeFromUser(isStartTime: false);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Get.isDarkMode ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyInputField(
                hint: "$_selectedRemind Minutes early",
                title: "Remind",
                widget: DropdownButton(
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRemind = int.parse(newvalue!);
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Get.isDarkMode ? Colors.white : Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                  )),
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()));
                    },
                  ).toList(),
                ),
              ),
              MyInputField(
                hint: _selectedRepeat,
                title: "Repeat",
                widget: DropdownButton(
                  onChanged: (String? newvalue) {
                    setState(() {
                      _selectedRepeat = newvalue!;
                    });
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Get.isDarkMode ? Colors.white : Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(
                    height: 0,
                  ),
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                  )),
                  items: repeatList.map<DropdownMenuItem<String>>(
                    (String? value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value!,
                              style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.grey[100]
                                    : Colors.grey[600],
                              )));
                    },
                  ).toList(),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorPallet(),
                  MyButton(
                    lable: "Create Task",
                    onTap: () => validateData(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Colors",
          style: GoogleFonts.lato(
              textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          )),
        ),
        Wrap(
          children: List<Widget>.generate(
              3,
              (int index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: index == 0
                            ? primaryclr
                            : index == 1
                                ? pinkclr
                                : yellowclr,
                        child: _selectedColor == index
                            ? const Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Container(),
                      ),
                    ),
                  )),
        )
      ],
    );
  }

  getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime(2018),
        lastDate: DateTime(2030));
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      // ignore: avoid_print
      print('Some thing went wrong');
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    // ignore: use_build_context_synchronously
    String formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
      // ignore: avoid_print
      print("Time Cancel");
    } else if (isStartTime == true) {
      setState(() {
        _startDate = formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endDate = formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startDate.split(":")[0]),
            minute: int.parse(_startDate.split(":")[1].split(" ")[0])));
  }

  validateData() {
    if (titleController.text.isNotEmpty &&
        discrptionController.text.isNotEmpty) {
      _addTaskToDB();
      Get.back();
    } else if (titleController.text.isEmpty ||
        discrptionController.text.isEmpty) {
      Get.snackbar("Required", "All feilds are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          colorText: Get.isDarkMode ? Colors.black : Colors.white,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    }
  }

  _addTaskToDB() async {
    int value = await _taskController.addTask(
        task: Task(
            discreption: discrptionController.text,
            title: titleController.text,
            date: DateFormat.yMd().format(_selectedDate),
            startTime: _startDate,
            endTime: _endDate,
            remind: _selectedRemind,
            repeat: _selectedRepeat,
            color: _selectedColor,
            isCompleted: 0));
    // ignore: avoid_print
    print("My ID Is $value");
  }
}
