// ignore_for_file: file_names, unnecessary_nullable_for_final_variable_declarations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _streamController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _gurdianController = TextEditingController();

  final CollectionReference _students =
      FirebaseFirestore.instance.collection('students');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _emailController.text = documentSnapshot['email'];
      _gradeController.text = documentSnapshot['grade'];
      _streamController.text = documentSnapshot['stream'];
      _contactNumberController.text = documentSnapshot['contact'];
      _gurdianController.text = documentSnapshot['gurdian'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _gradeController,
                  decoration: const InputDecoration(labelText: 'Grade'),
                ),
                TextField(
                  controller: _streamController,
                  decoration: const InputDecoration(labelText: 'Stream'),
                ),
                TextField(
                  controller: _contactNumberController,
                  decoration: const InputDecoration(labelText: 'Contact No'),
                ),
                TextField(
                  controller: _gurdianController,
                  decoration: const InputDecoration(labelText: 'Guardian Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final String? email = _emailController.text;
                    final String? grade = _gradeController.text;
                    final String? stream = _streamController.text;
                    final String? contact = _contactNumberController.text;
                    final String? gurdian = _gurdianController.text;

                    if (name != null &&
                        email != null &&
                        grade != null &&
                        stream != null &&
                        contact != null &&
                        gurdian != null) {
                      if (action == 'create') {
                        await _students.add({
                          "name": name,
                          "email": email,
                          "grade": grade,
                          "stream": stream,
                          "contactno": contact,
                          "gurdian": gurdian
                        });
                      }

                      if (action == 'update') {
                        await _students.doc(documentSnapshot!.id).update({
                          "name": name,
                          "email": email,
                          "grade": grade,
                          "stream": stream,
                          "contactno": contact,
                          "gurdian": gurdian
                        });
                      }

                      _nameController.text = '';
                      _emailController.text = '';
                      _gradeController.text = '';
                      _streamController.text = '';
                      _contactNumberController.text = '';
                      _gurdianController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a student by id
  Future<void> _deleteStudent(String studentId) async {
    await _students.doc(studentId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a Student')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
      ),
      body: StreamBuilder(
        stream: _students.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['email']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteStudent(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
