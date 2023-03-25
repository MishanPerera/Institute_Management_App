// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  final String uid;
  final String name;
  final String email;
  final String subject;
  final String contactNumber;
  final String grade;
  final String dateOfBirth;

  Teacher(
    this.uid,
    this.name,
    this.email,
    this.subject,
    this.contactNumber,
    this.grade,
    this.dateOfBirth,
  );

  factory Teacher.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Teacher(
      snapshot.id,
      snapshot['name'],
      snapshot['email'],
      snapshot['subject'],
      snapshot['contactNumber'],
      snapshot['grade'],
      snapshot['dateOfBirth'],
    );
  }
}
