import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Student.dart';


class StudentService {
  CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection("Students");

  Future<DocumentReference> createNewStudent(Student student) async {
    return await studentsCollection.add({
      "uid": student.sid,
      "name": student.sname,
      "courses": student.ssubject,
      "contactNumber": student.scontactNumber,
      "grade": student.sgrade,
      "dateOfBirth": student.sdateOfBirth,
    });
  }

  Future<void> updateStudent(Student student) async {
    await studentsCollection.doc(student.sid).update({
      "name": student.sname,
      "courses": student.ssubject,
      "contactNumber": student.scontactNumber,
      "grade": student.sgrade,
      "dateOfBirth": student.sdateOfBirth,
    });
  }

  Future<void> deleteStudent(String sid) async {
    await studentsCollection.doc(sid).delete();
  }

  List<Student> studentFromFirestore(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Student(
        doc["sid"],
        doc["sname"],
        doc["ssubject"],
        doc["scontactNumber"],
        doc["sgrade"],
        doc["sdateOfBirth"].toDate(),
      );
    }).toList();
  }

  Stream<List<Student>> listStudents() {
    return studentsCollection.snapshots().map(studentFromFirestore);
  }

  Future<List<Student>> getStudents() {
    return studentsCollection.get().then((querySnapshot) {
      List<Student> studentsList = [];
      for (var doc in querySnapshot.docs) {
        studentsList.add(
            studentFromFirestore(doc as QuerySnapshot<Object?>) as Student);
      }
      return studentsList;
    });
  }
}
