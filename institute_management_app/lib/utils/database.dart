import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/models/time_table_model.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);

//  Adds a new Time Table object to database.
Future addTimeTable(String name, int grade, String subject, List<String> days,
    TimeOfDay startTime, TimeOfDay endTime) async {
  final docTimeTable = FirebaseDatabase.instance.ref().child('timeTables');

  String timeTableId = docTimeTable.push().key!;

  final timeTable = TimeTable(
      id: timeTableId,
      name: name,
      grade: grade,
      subject: subject,
      startTime: startTime,
      endTime: endTime,
      days: days.map((day) => day.trim()).toList());

  final json = timeTable.toJson();
  await docTimeTable.push().set(json);
}

// Get List of TimeTable object that is present in the database
Stream<List<TimeTable>> getTimeTables() async* {
  try {
    // Return a stream of documents that belong to the current user
    yield* FirebaseDatabase.instance
        .ref()
        .child('timeTables')
        .onValue
        .map((event) {
      List<TimeTable> timeTables = [];
      // Convert the data snapshot to a Map
      Map<dynamic, dynamic> snapshotMap =
          event.snapshot.value as Map<dynamic, dynamic>;
      // Iterate over the keys of the map and convert each value to a TimeTable object
      snapshotMap.forEach((key, value) {
        timeTables.add(TimeTable.fromJson(key, value));
      });
      // Return the list of TimeTable objects as the result of the stream
      return timeTables;
    });
    // yield* FirebaseFirestore.instance.collection('timeTables').snapshots().map(
    //     (snapshots) => snapshots.docs
    //         .map((doc) => TimeTable.fromJson(doc.data()))
    //         .toList());
  } catch (e) {
    logger.e('Error fetching favourites: $e');
    yield [];
  }
}

// Edit an Time Table object that is present in the database.
Future<void> editTimeTable(
    String timeTableId, Map<String, dynamic> dataToUpdate) async {
  // Get a reference to the document to be updated
  final docRef =
      FirebaseDatabase.instance.ref().child('timeTables').child(timeTableId);
  // Update the document
  await docRef
      .update(dataToUpdate)
      .then((value) => logger.i('Time Table $timeTableId updated'))
      .catchError((error) =>
          logger.e('Failed to update Time Table $timeTableId: $error'));
}

// delete an Time Table object that is present in the database.
Future<void> deleteTimeTable(String timeTableId) async {
  final docRef =
      FirebaseDatabase.instance.ref().child('timeTables').child(timeTableId);

  // Delete the document
  await docRef
      .remove()
      .then((value) => logger.i('Time Table $timeTableId deleted'))
      .catchError((error) => logger.e('Failed to delete Time Table: $error'));
}
