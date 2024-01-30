import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_manager/DataBase/db_helper.dart';
import 'package:task_manager/Services/notification_services.dart';

import 'Services/themes_services.dart';
import 'UI/home.dart';
import 'UI/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyHelper().initializeNotification();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: Themes.dark,
      theme: Themes.light,
      themeMode: ThemeService().theme,
      title: 'Tasks Manager',
      home: const HomeScreen(),
    );
  }
}
