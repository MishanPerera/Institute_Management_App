// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/models/time_table_model.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final logger = Logger(
  level: Level.debug,
  printer: PrettyPrinter(),
);

//  Adds a new Time Table object to database.
void addTimeTable(String name, int grade, String subject, List<String> days,
    TimeOfDay startTime, TimeOfDay endTime) {
  final docTimeTable =
      FirebaseFirestore.instance.collection('timeTables').doc();

  String timeTableId = docTimeTable.id;

  final timeTable = TimeTable(
      id: timeTableId,
      name: name,
      grade: grade,
      subject: subject,
      startTime: '${startTime.hour}:${startTime.minute}',
      endTime: '${endTime.hour}:${endTime.minute}',
      days: days.map((day) => day.trim()).toList());

  final json = timeTable.toJson();
  docTimeTable
      .set(json)
      .then((_) => logger.i("Time table added successfully!"))
      .catchError((err) => logger.e('Error adding time table: $err'));
}

// Get List of TimeTable object that is present in the database
Stream<List<TimeTable>> getTimeTables() async* {
  try {
    // Return a stream of documents that belong to the current user
    yield* FirebaseFirestore.instance.collection('timeTables').snapshots().map(
        (snapshots) => snapshots.docs
            .map((doc) => TimeTable.fromJson(doc.data()))
            .toList());

    //     {
    //   List<TimeTable> timeTables = [];
    //   // Convert the data snapshot to a Map
    //   Map<dynamic, dynamic> snapshotMap =
    //       event.snapshot.value as Map<dynamic, dynamic>;
    //   // Iterate over the keys of the map and convert each value to a TimeTable object
    //   snapshotMap.forEach((key, value) {
    //     timeTables.add(TimeTable.fromJson(key, value));
    //   });
    //   // Return the list of TimeTable objects as the result of the stream
    //   return timeTables;
    // });
  } catch (e) {
    logger.e('Error fetching favourites: $e');
    yield [];
  }
}

// Edit an Time Table object that is present in the database.
void editTimeTable(String timeTableId, Map<String, dynamic> dataToUpdate) {
  // Get a reference to the document to be updated
  DocumentReference docRef =
      FirebaseFirestore.instance.collection('timeTables').doc(timeTableId);

  // Update the document
  docRef
      .update(dataToUpdate)
      .then((value) => logger.i('Time Table $timeTableId updated'))
      .catchError((error) =>
          logger.e('Failed to update Time Table $timeTableId: $error'));
  // final docRef =
  //     FirebaseDatabase.instance.ref().child('timeTables').child(timeTableId);
  // // Update the document
  // await docRef
  //     .update(dataToUpdate)
  //     .then((value) => logger.i('Time Table $timeTableId updated'))
  //     .catchError((error) =>
  //         logger.e('Failed to update Time Table $timeTableId: $error'));
}

// delete an Time Table object that is present in the database.
void deleteTimeTable(String timeTableId) {
  DocumentReference docRef =
      FirebaseFirestore.instance.collection('timeTables').doc(timeTableId);
  // Delete the document
  docRef
      .delete()
      .then((value) => logger.i('Time Table deleted'))
      .catchError((error) => logger.e('Failed to delete todo: $error'));

  // final docRef =
  //     FirebaseDatabase.instance.ref().child('timeTables').child(timeTableId);

  // // Delete the document
  // await docRef
  //     .remove()
  //     .then((value) => logger.i('Time Table $timeTableId deleted'))
  //     .catchError((error) => logger.e('Failed to delete Time Table: $error'));
}
