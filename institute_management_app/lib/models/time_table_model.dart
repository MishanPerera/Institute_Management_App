import 'package:flutter/material.dart';

class TimeTable {
  String id;
  String name;
  int grade;
  String subject;
  List<String> days;
  TimeOfDay startTime;
  TimeOfDay endTime;

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

  factory TimeTable.fromJson(key, Map<String, dynamic> json) {
    return TimeTable(
        id: key,
        name: json['name'],
        subject: json['subject'],
        grade: json['grade'],
        days: json['days'],
        startTime: json['startTime'],
        endTime: json['endTime']);
  }
}
