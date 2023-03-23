import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Teacher.dart';

class TeacherService {
  CollectionReference teachersCollection =
      FirebaseFirestore.instance.collection("Teachers");

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

  Stream<List<Teacher>> listTeachers() {
    return teachersCollection.snapshots().map(teacherFromFirestore);
  }
}
