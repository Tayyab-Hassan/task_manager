import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("flutter_logo");

    DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIos);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {});
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('Channel_id', 'Channel_title',
            channelShowBadge: true,
            priority: Priority.high,
            importance: Importance.max,
            icon: 'flutter_logo',
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await notificationsPlugin.show(
        0, 'Simple Notification', 'Welcome to Flutter', notificationDetails);
  }
}
