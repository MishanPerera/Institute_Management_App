import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/reusable_widgets/label_heading_widget.dart';
import '../utils/database.dart';

class AddDialogWidget extends StatefulWidget {
  const AddDialogWidget({super.key});

  @override
  State<AddDialogWidget> createState() => _AddDialogWidgetState();

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddDialogWidget(),
    );
  }
}

class _AddDialogWidgetState extends State<AddDialogWidget> {
  final names = ['Joseph', 'Stalin', 'Henry', 'Kane', 'Richardson'];
  final subjects = ['Biology', 'Physics', 'Chemistry', 'Combined Mathematics'];
  final grades = ['12', '13'];
  final List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek(
      "Mon",
    ),
    DayInWeek("Tue"),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];

  String name = '';
  String grade = '12';
  String subject = "";
  List<String> days = [];
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 30);

  void handleOnSelect(List<String> values) {
    setState(() {
      days = values.map((val) => val).toList();
    });
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
  Widget build(BuildContext context) {
    return AlertDialog(
      // Prompts the user to add a new time table.
      title: const Text('Add Time Table'),
      content: SingleChildScrollView(
        // Creates a scrollable content area
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
                  focusColor: Colors.transparent,
                  hint: subject == ""
                      ? const Text('Please Chose One')
                      : Text(
                          subject,
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
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
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
                  onPressed: () async {
                    final value = await selectTime(context, startTime);
                    setState(() {
                      startTime = value;
                    });
                  },
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
                  onPressed: () async {
                    final value = await selectTime(context, endTime);
                    setState(() {
                      endTime = value;
                    });
                  },
                  label: const Text('Pick'),
                ),
              ],
            ),
          ],
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
          child: const Text('ADD'),
          onPressed: () {
            if (name.isNotEmpty && subject.isNotEmpty && days.isNotEmpty) {
              addTimeTable(
                  name, int.parse(grade), subject, days, startTime, endTime);
              const snackBar = SnackBar(
                content: Text('Time Table Added Successfully'),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBar); // Displays a message to the user when a new task is added successfully.

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
