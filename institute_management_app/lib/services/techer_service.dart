import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import '../models/Teacher.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);

class TeacherService {
  CollectionReference teachersCollection =
      FirebaseFirestore.instance.collection("teachers");

  Future<DocumentReference> createNewTeacher(Teacher teacher) async {
    return await teachersCollection.add({
      "uid": teacher.uid,
      "name": teacher.name,
      "email": teacher.email,
      "courses": teacher.subject,
      "contactNumber": teacher.contactNumber,
      "grade": teacher.grade,
      "dateOfBirth": teacher.dateOfBirth,
    });
  }

  Future<void> updateTeacher(Teacher teacher) async {
    await teachersCollection.doc(teacher.uid).update({
      "name": teacher.name,
      "email": teacher.email,
      "courses": teacher.subject,
      "contactNumber": teacher.contactNumber,
      "grade": teacher.grade,
      "dateOfBirth": teacher.dateOfBirth,
    });
  }

  Future<void> deleteTeacher(String uid) async {
    await teachersCollection.doc(uid).delete();
  }

  List<Teacher> teacherFromFirestore(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Teacher(
        doc["uid"],
        doc["name"],
        doc["email"],
        doc["subject"],
        doc["contactNumber"],
        doc["grade"],
        doc["dateOfBirth"].toDate(),
      );
    }).toList();
  }

  Stream<List<Teacher>> listTeachers() async* {
    try {
      yield* teachersCollection
          .snapshots()
          .map((snapshot) => teacherFromFirestore(snapshot));
    } catch (e) {
      logger.e('Error fetching Teacher Details: $e');
      yield [];
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
