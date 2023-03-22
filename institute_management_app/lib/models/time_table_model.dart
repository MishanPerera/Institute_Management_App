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
}
