// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:institute_management_app/models/Teacher.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);

class TeacherService {
  final CollectionReference _teachersCollection =
      FirebaseFirestore.instance.collection('teachers');

  // CREATE
  Future<void> addTeacher(Teacher teacher) async {
    try {
      await _teachersCollection.doc(teacher.uid).set({
        'name': teacher.name,
        'email': teacher.email,
        'subject': teacher.subject,
        'contactNumber': teacher.contactNumber,
        'grade': teacher.grade,
        'dateOfBirth': teacher.dateOfBirth,
      });
    } catch (e) {
      print(e);
    }
  }

  // READ and SEARCH
  Stream<List<Teacher>>? getTeachers(String search) {
    try {
      return _teachersCollection
          .where('name', isGreaterThanOrEqualTo: search)
          .where('name', isLessThan: '${search}z')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Teacher(
                  doc.id,
                  doc['name'],
                  doc['email'],
                  doc['subject'],
                  doc['contactNumber'],
                  doc['grade'],
                  doc['dateOfBirth'],
                ))
            .toList();
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  // UPDATE
  Future<void> updateTeacher(Teacher teacher) async {
    try {
      await _teachersCollection.doc(teacher.uid).update({
        'name': teacher.name,
        'email': teacher.email,
        'subject': teacher.subject,
        'contactNumber': teacher.contactNumber,
        'grade': teacher.grade,
        'dateOfBirth': teacher.dateOfBirth,
      });
    } catch (e) {
      print(e);
    }
  }

  // DELETE
  Future<void> deleteTeacher(String uid) async {
    try {
      await _teachersCollection.doc(uid).delete();
    } catch (e) {
      print(e);
    }
  }

  // Future<List<Teacher>> getTeachers() {
  //   return teachersCollection.get().then((querySnapshot) {
  //     List<Teacher> teachersList = [];
  //     for (var doc in querySnapshot.docs) {
  //       teachersList.add(
  //           teacherFromFirestore(doc as QuerySnapshot<Object?>) as Teacher);
  //     }
  //     return teachersList;
  //   });
  // }
}
