import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:task_manager/Models/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //
  Future<void> initializeNotification() async {
    configurationTimzone();
    // final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    // this is for latest iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("flutter_logo");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future selectNotification(dynamic payload) async {
    if (payload != null) {
    } else {}
    Get.to(() => Container(
          color: Colors.white,
        ));
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );

    Get.dialog(const Text('Welcom to Flutter'));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> displayNotification(
      {required String title, required String body}) async {
    // ignore: avoid_print
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        icon: 'flutter_logo',
        largeIcon: DrawableResourceAndroidBitmap('flutter_logo'),
        channelShowBadge: true,
        importance: Importance.max,
        priority: Priority.high);
    var iOSplatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSplatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
    // ignore: avoid_print
    print(title);
  }

  scheduledNotification(int hour, int minutes, Task task) async {
    // ignore: avoid_print
    print('Scheduling notification for: ${_convertTime(hour, minutes)}');
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'theme changes 5 seconds ago',
        _convertTime(hour, minutes),
        // tz.TZDateTime.now(tz.local).add(Duration(seconds: minutes)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
          ),
        ),
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  // ignore: unused_element
  tz.TZDateTime _convertTime(int hours, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime secheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hours, minutes);
    if (secheduleDate.isBefore(now)) {
      secheduleDate = secheduleDate.add(const Duration(days: 1));
    }
    return secheduleDate;
  }

  Future<void> configurationTimzone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
