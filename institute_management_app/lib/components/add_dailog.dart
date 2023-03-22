import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
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
  final formKey = GlobalKey<FormState>();
  final names = ['Joseph', 'Stalin', 'Henry', 'Kane', 'Richardson'];
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
  String subject = "";
  int grade = 1;
  List<String> days = [];
  TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 30);

  // endTime.format(context).toString()
  void handleOnSelect(List<String> values) {
    days = values.map((val) => val).toList();
    print(days);
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
      // Prompts the user to add a new task.
      title: const Text('Add Task'),
      content: SingleChildScrollView(
        // Creates a scrollable content area
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
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
              const SizedBox(height: 16.0),
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Sub Task',
                  helperText: "Ex: Potatoes, Carrots",
                ),
                validator: (value) {
                  if (!RegExp(r'^[a-z A-Z ,]+$').hasMatch(value!)) {
                    // Sub Task can be Empty but should contain alphabets commas and whitespaces
                    return "Enter correct Sub Task";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  subject = value.trim();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: const EdgeInsets.all(8.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 1)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: name,
                    isExpanded: true,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: names.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() {
                      name = value!;
                    }),
                  ),
                ),
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
          child: const Text('ADD'),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              addTimeTable(name, grade, subject, days, startTime, endTime);
              const snackBar = SnackBar(
                content: Text('Task Added Successfully'),
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

  DropdownMenuItem<String> buildMenuItem(String name) => DropdownMenuItem(
        value: name,
        child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
