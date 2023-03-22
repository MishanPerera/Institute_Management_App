import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/models/time_table_model.dart';
import 'package:institute_management_app/reusable_widgets/label_heading_widget.dart';

import '../utils/database.dart';

class UpdateDialogWidget extends StatefulWidget {
  final TimeTable timeTable;
  final String name;
  final String grade;
  final String subject;
  final List<String> days;
  final String startTime;
  final String endTime;

  const UpdateDialogWidget({
    super.key,
    required this.timeTable,
    required this.name,
    required this.grade,
    required this.subject,
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  @override
  State<UpdateDialogWidget> createState() => _UpdateDialogWidgetState();

  static Future<void> show(
      BuildContext context,
      TimeTable timeTable,
      String name,
      String grade,
      String subject,
      List<String> days,
      String startTime,
      String endTime) async {
    await showDialog(
      context: context,
      builder: (context) => UpdateDialogWidget(
        timeTable: timeTable,
        name: name,
        grade: grade,
        subject: subject,
        days: days,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }
}

class _UpdateDialogWidgetState extends State<UpdateDialogWidget> {
  final formKey = GlobalKey<FormState>();
  late String name;
  late String subject;
  late String grade;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late List<String> days;

  final names = ['Joseph', 'Stalin', 'Henry', 'Kane', 'Richardson'];
  final List<String> grades = ['12', '13'];
  final List<String> subjects = [
    "Biology",
    "Combined Mathematics",
    "Physics",
    "Chemistry"
  ];
  final List<DayInWeek> _days = [
    DayInWeek("Sun", isSelected: false),
    DayInWeek("Mon", isSelected: false),
    DayInWeek("Tue", isSelected: false),
    DayInWeek("Wed", isSelected: false),
    DayInWeek("Thu", isSelected: false),
    DayInWeek("Fri", isSelected: false),
    DayInWeek("Sat", isSelected: false),
  ];

  void handleOnSelect(List<String> values) {
    setState(() {
      days = values.map((val) => val).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    name = widget.name;
    subject = widget.subject;
    grade = widget.grade;
    startTime = TimeOfDay(
        hour: int.parse(widget.startTime.split(':')[0]),
        minute: int.parse(widget.startTime.split(':')[1]));
    endTime = TimeOfDay(
        hour: int.parse(widget.endTime.split(':')[0]),
        minute: int.parse(widget.endTime.split(':')[1]));
    days = widget.days;

    for (var day in _days) {
      if (days.contains(day.dayName)) {
        day.isSelected = true;
      }
    }
    super.initState();
  }

  Future<TimeOfDay> selectTime(
      BuildContext context, TimeOfDay initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      return picked;
    }
    return initialTime;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Prompts the user to update a time table.
      title: const Text('Update Time Table'),
      content: SingleChildScrollView(
        // Creates a scrollable content area
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const LabelHeading(label: "Teacher Name:"),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: name,
                    focusColor: Colors.transparent,
                    hint: name == ""
                        ? const Text('Please Chose One')
                        : Text(
                            name,
                            style: const TextStyle(color: Colors.blue),
                          ),
                    isExpanded: true,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: names.map((name) {
                      return buildMenuItem(name);
                    }).toList(),
                    onChanged: (value) => setState(() {
                      name = value!;
                    }),
                  ),
                ),
              ),
              const LabelHeading(label: "Grade:"),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: grade,
                    focusColor: Colors.transparent,
                    hint: grade == ""
                        ? const Text('Please Chose One')
                        : Text(
                            grade,
                            style: const TextStyle(color: Colors.blue),
                          ),
                    isExpanded: true,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: grades.map((grade) {
                      return buildMenuItem(grade);
                    }).toList(),
                    onChanged: (value) => setState(() {
                      grade = value!;
                    }),
                  ),
                ),
              ),
              const LabelHeading(label: "Subject:"),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: subject,
                    focusColor: Colors.transparent,
                    hint: widget.subject == ""
                        ? const Text('Please Chose One')
                        : Text(
                            widget.subject,
                            style: const TextStyle(color: Colors.blue),
                          ),
                    isExpanded: true,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: subjects.map((subject) {
                      return buildMenuItem(subject);
                    }).toList(),
                    onChanged: (value) => setState(() {
                      subject = value!;
                    }),
                  ),
                ),
              ),
              const LabelHeading(label: "Days:"),
              const SizedBox(
                height: 8,
              ),
              SelectWeekDays(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                days: _days,
                border: false,
                boxDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [Color(0xFFE55CE4), Color(0xFFBB75FB)],
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
                onSelect: (values) => handleOnSelect(values),
              ),
              const SizedBox(
                height: 12,
              ),
              const LabelHeading(label: "Start Time:"),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(startTime.format(context).toString()),
                  )),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        fixedSize: const Size(120, 40),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red),
                    icon: const Icon(Icons.timer_outlined),
                    onPressed: () =>
                        selectTime(context, startTime).then((value) => setState(
                              () {
                                startTime = value;
                              },
                            )),
                    label: const Text('Pick'),
                  ),
                ],
              ),
              const LabelHeading(label: "End Time:"),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(endTime.format(context).toString()),
                  )),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        fixedSize: const Size(120, 40),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red),
                    icon: const Icon(Icons.timer_outlined),
                    onPressed: () =>
                        selectTime(context, endTime).then((value) => setState(
                              () {
                                endTime = value;
                              },
                            )),
                    label: const Text('Pick'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('UPDATE'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              editTimeTable(widget.timeTable.id, {
                'id': widget.timeTable.id,
                'name': name,
                'grade': int.parse(grade),
                'subject': subject,
                'days': days,
                'startTime': '${startTime.hour}:${startTime.minute}',
                'endTime': '${endTime.hour}:${endTime.minute}',
              });

              const snackBar = SnackBar(
                content: Text('Time Table Updated Successfully'),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBar); // Displays a message to the user when an existing task is updated successfully.

              Navigator.of(context)
                  .pop(); // Dismiss the dialog and return to the main screen.
            }
          },
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String value) => DropdownMenuItem(
        value: value,
        child: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
