import 'package:flutter/material.dart';
import 'package:institute_management_app/models/time_table_model.dart';

import '../utils/database.dart';

class UpdateDialogWidget extends StatefulWidget {
  final TimeTable timeTable;
  final String name;
  final int grade;
  final String subject;
  final List<String> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

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
      int grade,
      String subject,
      List<String> days,
      TimeOfDay startTime,
      TimeOfDay endTime) async {
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
  late int grade;
  late String taskSubtitle;
  final nameList = ['Joseph', 'Stalin', 'Henry', 'Kane', 'Richardson'];
  final List<int> gradeList = [12, 13];
  final List<String> subjectList = [
    "Biology",
    "Combined Mathematics",
    "Physics",
    "Chemistry"
  ];

  late TextEditingController _nameController;
  late TextEditingController _subtitleController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _subtitleController = TextEditingController(text: widget.subject);
    name = widget.name;
    taskSubtitle = widget.subject;
  }

  // void handleOnSelect(List<String> values) {
  //   days = values.map((val) => val).toList();
  //   print(days);
  // }

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
    _nameController.dispose();
    _subtitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Prompts the user to add a new task.
      title: const Text('Update Task'),
      content: SingleChildScrollView(
        // Creates a scrollable content area
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Main Task",
                  helperText: "Ex: Shopping",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    // Main Task cannot be Empty and should contain alphabets
                    return "Enter correct Main Task";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  name = value.trim();
                },
              ),
              TextFormField(
                controller: _subtitleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Sub Task",
                  helperText: "Ex: Potatoes, Carrots",
                ),
                validator: (value) {
                  if (!RegExp(r'^[a-z A-Z ,]+$').hasMatch(value!)) {
                    // Sub Task cannot be Empty but should contain alphabets commas and whitespaces
                    return "Enter correct Sub Task";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  taskSubtitle = value.trim();
                },
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
                'subtitle': "None",
                'isComplete': widget.days
              });

              const snackBar = SnackBar(
                content: Text('Task Updated Successfully'),
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
}
