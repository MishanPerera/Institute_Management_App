import 'package:cloud_firestore/cloud_firestore.dart';

class TimeTable {
  String id;
  String name;
  int grade;
  String subject;
  List<String> days;
  String startTime;
  String endTime;

  TimeTable(
      {required this.id,
      required this.name,
      required this.subject,
      required this.grade,
      required this.days,
      required this.startTime,
      required this.endTime});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subject': subject,
        'grade': grade,
        'days': days,
        'startTime': startTime,
        'endTime': endTime,
      };

  factory TimeTable.fromJson(Map<String, dynamic> json) {
    return TimeTable(
        id: json['id'],
        name: json['name'],
        subject: json['subject'],
        grade: json['grade'],
        days: List<String>.from(json['days']),
        startTime: json['startTime'],
        endTime: json['endTime']);
  }

  factory TimeTable.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return TimeTable(
      id: snapshot.id,
      name: snapshot['name'],
      subject: snapshot['subject'],
      grade: snapshot['grade'],
      days: List<String>.from(snapshot['days']),
      startTime: snapshot['startTime'],
      endTime: snapshot['endTime'],
    );
  }
}
