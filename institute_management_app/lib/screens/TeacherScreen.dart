// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, avoid_print, depend_on_referenced_packages, prefer_adjacent_string_concatenation

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/models/Teacher.dart';
import 'package:institute_management_app/services/techer_service.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class TeacherScreen extends StatefulWidget {
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  final TeacherService _teacherService = TeacherService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateinput = TextEditingController();
  String _searchString = '';

  late String _name;
  late String _email;
  late String _subject;
  late String _contactNumber;
  late String _grade;
  late String _dateOfBirth;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.blue])),
        child: Scaffold(
          // By defaut, Scaffold background is white
          // Set its value to transparent
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.only(left: 20),
              icon: const Icon(Icons.menu),
              onPressed: () => ZoomDrawer.of(context)!.toggle(),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 20),
                onPressed: () {
                  _showTeacherDialog(context);
                },
                tooltip: 'Add Teacher',
                icon: const Icon(Icons.add),
              ),
            ],
            title: Text('Teachers'),
          ),
          body: Column(children: [
            Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Teachers',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      _searchString = value;
                    });
                  },
                )),
            Expanded(
              child: StreamBuilder<List<Teacher>>(
                stream: _teacherService.getTeachers(_searchString),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.white,)
                      
                    );
                  }

                  List<Teacher> teachers = snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: teachers.length,
                    itemBuilder: (context, index) {
                      Teacher teacher = teachers[index];

                      return Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.transparent,
                        child: ListTile(
                          tileColor: Colors.transparent,
                          title: Text(
                            teacher.name,
                            style: TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            teacher.subject,
                            style: TextStyle(
                              color: Colors.white70,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white70,
                            ),
                            onPressed: () {
                              _teacherService.deleteTeacher(teacher.uid);
                            },
                          ),
                          onTap: () {
                            _showTeacherDialog(context, teacher: teacher);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ]),
        ));
  }

  void _showTeacherDialog(BuildContext context, {Teacher? teacher}) {
    bool isEditing = teacher != null;

    if (isEditing) {
      _name = teacher.name;
      _email = teacher.email;
      _subject = teacher.subject;
      _contactNumber = teacher.contactNumber;
      _grade = teacher.grade;
      _dateOfBirth = teacher.dateOfBirth;
    } else {
      _name = '';
      _email = '';
      _subject = '';
      _contactNumber = '';
      _grade = '';
      _dateOfBirth = '';
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Teacher' : 'Add Teacher'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.person),
                    focusColor: Color.fromARGB(255, 0, 89, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.00)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                SizedBox(
                  width: 400, // specify the width
                  height: 10, // specify the height
                ),
                TextFormField(
                  initialValue: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                    focusColor: Color.fromARGB(255, 0, 89, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.00)),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Enter a valid email';
                    }
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(
                  width: 400, // specify the width
                  height: 10, // specify the height
                ),
                TextFormField(
                  initialValue: _subject,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    icon: Icon(Icons.subject),
                    focusColor: Color.fromARGB(255, 0, 89, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.00)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _subject = value!;
                  },
                ),
                SizedBox(
                  width: 400, // specify the width
                  height: 10, // specify the height
                ),
                TextFormField(
                  initialValue: _contactNumber,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    icon: Icon(Icons.phone),
                    focusColor: Color.fromARGB(255, 0, 89, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.00)),
                  ),
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _contactNumber = value!;
                  },
                ),
                SizedBox(
                  width: 400, // specify the width
                  height: 10, // specify the height
                ),
                TextFormField(
                  initialValue: _grade,
                  decoration: InputDecoration(
                    labelText: 'Grade',
                    focusColor: Color.fromARGB(255, 0, 89, 255),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.00)),
                    icon: Icon(Icons.grade),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a grade';
                    } else if (int.parse(value) > 13 || int.parse(value) < 12) {
                      return 'Please enter a valid grade (Grade 12 / Grade 13)';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    _grade = "Grade" + " " + value!;
                  },
                ),
                SizedBox(
                  width: 400, // specify the width
                  height: 10, // specify the height
                ),
                TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      focusColor: Color.fromARGB(255, 0, 89, 255),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.00)),
                      labelText: "Date of birth" //label text of field
                      ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            1970), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2024));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                        _dateOfBirth = formattedDate;
                        //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isEditing ? 'Save' : 'Add'),
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                _formKey.currentState!.save();

                if (isEditing) {
                  final teachers = Teacher(
                    teacher.uid,
                    _name,
                    _email,
                    _subject,
                    _contactNumber,
                    _grade,
                    _dateOfBirth,
                  );
                  await _teacherService.updateTeacher(teachers);
                } else {
                  final teachers = Teacher(
                    Uuid().v4(),
                    _name,
                    _email,
                    _subject,
                    _contactNumber,
                    _grade,
                    _dateOfBirth,
                  );

                  await _teacherService.addTeacher(teachers);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
