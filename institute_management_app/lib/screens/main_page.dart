import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:institute_management_app/models/menu_page_model.dart';
import 'package:institute_management_app/screens/menu_page.dart';

import 'package:institute_management_app/screens/time_table_screen.dart';
import 'package:institute_management_app/screens/noticeDisplayScreen.dart';
import 'package:institute_management_app/screens/TeacherScreen.dart';
import 'package:institute_management_app/screens/sample_page_3.dart';
import 'package:institute_management_app/screens/AboutUsPage.dart';
import 'package:institute_management_app/screens/sample_page_5.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MenuItem currentItem = MenuItems.timeTable;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      showShadow: true,
      menuBackgroundColor: Colors.indigo,
      drawerShadowsBackgroundColor: Colors.orangeAccent,
      mainScreen: getScreen(),
      menuScreen: Builder(
        builder: (context) => MenuPage(
          currentItem: currentItem,
          onSelectedItem: (MenuItem value) {
            setState(() {
              currentItem = value;
              ZoomDrawer.of(context)!.close();
            });
          },
        ),
      ),
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.timeTable:
        return const TimeTableScreen(
          title: 'Time Table',
        );
      case MenuItems.notice:
        return const noticeDisplay();
      case MenuItems.teacher:
        return TeacherScreen();
      case MenuItems.help:
        return const SamplePage3();
      case MenuItems.aboutUs:
        return AboutUsPage();
      default:
        return const SamplePage5();
    }
  }
}
