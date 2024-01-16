import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../theme.dart';
import 'button.dart';

// ignore: must_be_immutable
class MyWidgets extends StatelessWidget {
  DateTime? selectedDate;
  final Function()? ontap;
  final Function()? addtask;
  MyWidgets({super.key, this.ontap, this.selectedDate, this.addtask});

  @override
  Widget build(BuildContext context) {
    return Container();
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
            onTap: addtask,
          )
        ],
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
          selectedDate = date;
        },
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
          onTap: ontap,
          child: Get.isDarkMode != false
              ? const Icon(
                  Icons.nightlight_round_outlined,
                  color: Colors.black,
                )
              : Icon(
                  Icons.sunny,
                  color: Colors.grey[200],
                )),
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
