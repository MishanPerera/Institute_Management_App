import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/components/add_dailog.dart';
import 'package:institute_management_app/components/build_content.dart';
import 'package:institute_management_app/models/time_table_model.dart';
import 'package:institute_management_app/reusable_widgets/label_heading_widget.dart';
import 'package:institute_management_app/screens/filtered_table_screen.dart';
import 'package:institute_management_app/screens/time_table_help.dart';
import 'package:institute_management_app/services/time_table_service.dart';
import 'package:quickalert/quickalert.dart';

import '../main.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key, required this.title});
  final String title;

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String email = "insafnilam.2000@gmail.com";
  User? _user;

  final _scrollController = ScrollController();
  double _opacity = 0.0;
  double _padding = 0.0;
  final List<String> grades = ["12", "13"];
  final List<String> subjects = [
    "Biology",
    "Chemistry",
    "Physics",
    "Combined Mathematics"
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _padding = 8.0;
      });
    });
    _user = _auth.currentUser;
  }

  // Responsible for cleaning up resources and ensuring that the application is closed properly
  @override
  void dispose() {
    super.dispose();
    // Free up any resources that the ScrollController uses
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151e3d),
      appBar: AppBar(
        backgroundColor: const Color(0xff191923),
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => ZoomDrawer.of(context)!.toggle()),
        actions: [
          Visibility(
            visible: _user!.email == email,
            child: IconButton(
              onPressed: () {
                // Display a dialog on top of the current widget, which allows the user to input new data and add it to the application.
                AddDialogWidget.show(context);
              },
              tooltip: 'showDailog',
              icon: const Icon(Icons.add),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TableHelp(),
              ),
            ),
            tooltip: 'showInfo',
            icon: const Icon(Icons.info),
          ),
        ],
        title: Text(widget.title),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.all(_padding),
        child: Opacity(
          opacity: _opacity,
          child: Column(children: [
            const SizedBox(
              height: 16,
            ),
            const LabelHeading(
              label: 'Grades:',
              color: Color(0xffffffff),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: grades
                  .map(
                    (grade) => InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilterTableScreen(
                            filterValue: grade,
                            filterLabel: 'grade',
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xffACE1AF),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Text(
                          grade,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Column(
              children: [
                const LabelHeading(
                    label: 'Subjects:', color: Color(0xffffffff)),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Row(
                        children: subjects
                            .sublist(0, (subjects.length / 2).ceil())
                            .map(
                              (subject) => InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FilterTableScreen(
                                      filterValue: subject,
                                      filterLabel: "subject",
                                    ),
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(20),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: subject == "Biology"
                                        ? const Color(0xff03A89E)
                                        : const Color(0xff4682B4),
                                  ),
                                  child: Center(child: Text(subject)),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      Row(
                        children: subjects
                            .sublist((subjects.length / 2).ceil())
                            .map(
                              (subject) => InkWell(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FilterTableScreen(
                                      filterValue: subject,
                                      filterLabel: "subject",
                                    ),
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(20),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: subject == "Physics"
                                        ? const Color(0xffcd3700)
                                        : const Color(0xffff9912),
                                  ),
                                  child: Center(child: Text(subject)),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const LabelHeading(label: 'Time Tables:', color: Color(0xffffffff)),
            Expanded(
              child: StreamBuilder<List<TimeTable>>(
                stream: getTimeTables(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Something went wrong!',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<TimeTable> timeTables = snapshot.data!;

                    timeTables.sort((a, b) {
                      int subjectComparison = a.subject.compareTo(b.subject);
                      if (subjectComparison != 0) {
                        return subjectComparison;
                      }
                      return a.grade.compareTo(b.grade);
                    });
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: timeTables.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (BuildContext context, int index) {
                            TimeTable timeTable = timeTables[index];
                            return BuildContent(timeTable: timeTable);
                          }),
                    );
                  } else {
                    return const Center(child: Text('No data to display'));
                  }
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
