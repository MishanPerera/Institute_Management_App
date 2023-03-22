
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:quickalert/quickalert.dart';

import '../main.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key, required this.title});
  final String title;

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final _scrollController = ScrollController();

  // Responsible for cleaning up resources and ensuring that the application is closed properly
  @override
  void dispose() {
    super.dispose();
    // Free up any resources that the ScrollController uses
    _scrollController.dispose();
  }

  void handleLogout() {
    QuickAlert.show(
        context: context,
        title: 'Do you want to logout?',
        type: QuickAlertType.confirm,
        barrierDismissible: true,
        cancelBtnText: 'No',
        confirmBtnText: 'Yes',
        onConfirmBtnTap: () {
          signOut();
        });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    navigatorKey.currentState!.pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffbd9a6e),
        appBar: AppBar(
          backgroundColor: const Color(0xff3c6440),
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => ZoomDrawer.of(context)!.toggle()),
          actions: [
            IconButton(
              onPressed: () {
                // Display a dialog on top of the current widget, which allows the user to input new data and add it to the application.
              },
              tooltip: 'showDailog',
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: handleLogout,
              tooltip: 'log out',
              icon: const Icon(Icons.logout),
            ),
          ],
          title: Text(widget.title),
        ),
        body: const Center(child: Text("Dashboard")));
  }
}
