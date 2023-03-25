
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/main.dart';
import 'package:institute_management_app/models/Student.dart';
import 'package:institute_management_app/services/student_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
class StudentScreen extends StatelessWidget {
  const StudentScreen({Key? key}) : super(key: key);

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

    void showAddStudentDialog() {
      final _sidController = TextEditingController();
      final _snameController = TextEditingController();
      final _ssubjectController = TextEditingController();
      final _scontactNumberController = TextEditingController();
      final _sgradeController = TextEditingController();
      final _sdobController = TextEditingController();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Student'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  TextFormField(
                    controller: _sidController,
                    decoration: const InputDecoration(
                      hintText: 'Student ID',
                      
                    ),
                  ),

                  TextFormField(
                    controller: _snameController,
                    decoration: const InputDecoration(
                      hintText: 'Student Name',
                      
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _ssubjectController,
                    decoration: const InputDecoration(
                      hintText: 'Subject',
                    ),
                    
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _scontactNumberController,
                    decoration: const InputDecoration(
                      hintText: 'Student Contact Number',
                    ),
                   
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _sgradeController,
                    decoration: const InputDecoration(
                      hintText: 'Grade',
                    ),
                    
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _sdobController,
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
                  final student = Student(
                    _sidController.text,
                     _snameController.text,
                     _ssubjectController.text,
                     _scontactNumberController.text,
                   _sgradeController.text,
                   _sdobController.text 

                  );

                  await StudentService().createNewStudent(student);
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
            onPressed: showAddStudentDialog,
            tooltip: 'Add Student',
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: handleLogout,
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text("Student"),
      ),



      body: 
        StreamBuilder<List<Student>>(
  stream:StudentService().listStudents(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return CircularProgressIndicator();
      default:
        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            Student student = snapshot.data![index];
            return ListTile(
              title: Text(student.sname),
              subtitle: Text(student.ssubject),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await StudentService().deleteStudent(student.sid);
                },
                tooltip: 'Delete Student',
          
              ),
            );
          },
        );
    }
  },
)
        
      );

    
   
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    navigatorKey.currentState!.pushReplacementNamed('/login');
  }


  
}
