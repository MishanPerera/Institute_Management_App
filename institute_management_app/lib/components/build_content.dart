import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:institute_management_app/components/update_dailog.dart';
import 'package:quickalert/quickalert.dart';

import '../utils/database.dart';
import 'package:institute_management_app/models/time_table_model.dart';

class BuildContent extends StatelessWidget {
  final TimeTable timetable;

  const BuildContent({
    super.key,
    required this.timetable,
  });

  @override
  Widget build(BuildContext context) {
    // Dailog Box to Handle Logout
    void handleDelete() {
      QuickAlert.show(
          context: context,
          title: 'Do you want to delete?',
          type: QuickAlertType.confirm,
          barrierDismissible: true,
          cancelBtnText: 'No',
          confirmBtnText: 'Yes',
          onConfirmBtnTap: () {
            deleteTimeTable(timetable.id);
            const snackBar = SnackBar(
              content: Text('Time Table Deleted Successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.of(context).pop();
          });
    }

    return Column(
      children: [
        Slidable(
          startActionPane: ActionPane(
            // On Sliding to the right side of the container, the widget displays an edit button, once clicked opens a dialog where the user can edit the todo item's properties from the Local Database.
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              const SizedBox(width: 8),
              SlidableAction(
                onPressed: ((context) {
                  UpdateDialogWidget.show(
                      context,
                      timetable,
                      timetable.name,
                      timetable.grade.toString(),
                      timetable.subject,
                      timetable.days,
                      timetable.startTime,
                      timetable.endTime);
                }),
                borderRadius: BorderRadius.circular(8.0),
                icon: Icons.edit,
                foregroundColor: Colors.white,
                backgroundColor: Colors.green.shade500,
              ),
              const SizedBox(width: 8),
            ],
          ),
          endActionPane: ActionPane(
              // On Sliding to the left side of the container, the widget displays an delete button, once clicked opens a dialog where the user can delete the todo item from the Local Database.
              motion: const ScrollMotion(),
              extentRatio: 0.2,
              children: [
                const SizedBox(width: 8),
                SlidableAction(
                  onPressed: ((context) {
                    handleDelete();
                  }),
                  borderRadius: BorderRadius.circular(8.0),
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade400,
                  foregroundColor: Colors.white,
                ),
                const SizedBox(width: 8),
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 20),
                ]),
            child: ListTile(
              dense: true,
              title: Text(
                timetable.name,
              ), // Depending on whether a task is complete or incomplete, the widgets will fade or be normal.
              subtitle: Text(
                timetable.subject,
              ),
              leading: const Icon(
                Icons.task_outlined,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
