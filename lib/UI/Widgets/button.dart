import 'package:flutter/material.dart';
import 'package:task_manager/UI/theme.dart';

class MyButton extends StatelessWidget {
  final String lable;
  final Function()? onTap;
  const MyButton({super.key, required this.lable, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryclr),
        child: Center(
            child: Text(
          lable,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
