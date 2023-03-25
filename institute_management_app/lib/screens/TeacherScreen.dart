// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/main.dart';
import 'package:institute_management_app/models/Teacher.dart';
import 'package:institute_management_app/services/techer_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    void showAddTeacherDialog() {
      final _uidController = TextEditingController();
      final _nameController = TextEditingController();
      final _emailController = TextEditingController();
      final _subjectController = TextEditingController();
      final _contactNumberController = TextEditingController();
      final _gradeController = TextEditingController();
      final _dobController = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Teacher'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _uidController,
                    decoration: const InputDecoration(
                      hintText: 'ID',
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _subjectController,
                    decoration: const InputDecoration(
                      hintText: 'Subject',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _contactNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Contact Number',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _gradeController,
                    decoration: const InputDecoration(
                      hintText: 'Grade',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                      hintText: 'Date of Birth',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final teacher = Teacher(
                      _uidController.text,
                      _nameController.text,
                      _emailController.text,
                      _subjectController.text,
                      _contactNumberController.text,
                      _gradeController.text,
                      _dobController.text);

                  await TeacherService().createNewTeacher(teacher);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => ZoomDrawer.of(context)!.toggle(),
          ),
          actions: [
            IconButton(
              onPressed: showAddTeacherDialog,
              tooltip: 'Add Teacher',
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: handleLogout,
              tooltip: 'Log out',
              icon: const Icon(Icons.logout),
            ),
          ],
          title: const Text("Teacher"),
        ),
        body: StreamBuilder<List<Teacher>>(
          stream: TeacherService().listTeachers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    Teacher teacher = snapshot.data![index];
                    return ListTile(
                      title: Text(teacher.name),
                      subtitle: Text(teacher.subject),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await TeacherService().deleteTeacher(teacher.uid);
                        },
                        tooltip: 'Delete Teacher',
                      ),
                    );
                  },
                );
            }
          },
        ));
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    navigatorKey.currentState!.pushReplacementNamed('/login');
  }
}
