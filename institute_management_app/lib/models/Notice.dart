import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  String id;
  final String heading;
  final String classType;
  final String description;
  final String category;

  Notice(
    this.id,
    this.heading,
    this.classType,
    this.description,
    this.category,
  );
}
