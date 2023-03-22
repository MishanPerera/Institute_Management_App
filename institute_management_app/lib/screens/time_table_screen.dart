import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/components/build_content.dart';
import 'package:institute_management_app/models/time_table_model.dart';
import 'package:institute_management_app/utils/database.dart';
import 'package:quickalert/quickalert.dart';

import '../main.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key, required this.title});
  final String title;

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
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
          )
        ],
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<TimeTable>>(
        stream: getTimeTables(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<TimeTable> timeTables = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: timeTables.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    TimeTable timeTable = timeTables[index];
                    return BuildContent(timetable: timeTable);
                  }),
            );
          } else {
            return const Center(child: Text('No data to display'));
          }
        },
      ),
    );
  }
}
