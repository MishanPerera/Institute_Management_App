import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:institute_management_app/components/update_dailog.dart';
import 'package:quickalert/quickalert.dart';

import '../services/time_table_service.dart';
import 'package:institute_management_app/models/time_table_model.dart';

class BuildContent extends StatefulWidget {
  final TimeTable timeTable;

  const BuildContent({
    super.key,
    required this.timeTable,
  });

  @override
  State<BuildContent> createState() => _BuildContentState();
}

class _BuildContentState extends State<BuildContent> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String email = "insafnilam.2000@gmail.com";
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    // Dailog Box to Handle Logout
    void handleDelete() async {
      await QuickAlert.show(
          context: context,
          title: 'Delete Time Table?',
          text:
              "Are you sure to delete this context?\nYou can't revert this action.",
          type: QuickAlertType.confirm,
          animType: QuickAlertAnimType.slideInUp,
          autoCloseDuration: const Duration(seconds: 5),
          barrierDismissible: true,
          cancelBtnText: 'No',
          confirmBtnText: 'Yes',
          onCancelBtnTap: () {
            Navigator.of(context).pop();
          },
          onConfirmBtnTap: () {
            deleteTimeTable(widget.timeTable.id);
            const snackBar = SnackBar(
              content: Text('Time Table Deleted Successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.of(context).pop();
          });
    }

    return Column(
      children: [
        Visibility(
          visible: _user!.email == email,
          child: Slidable(
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
                        widget.timeTable,
                        widget.timeTable.name,
                        widget.timeTable.grade.toString(),
                        widget.timeTable.subject,
                        widget.timeTable.days,
                        widget.timeTable.startTime,
                        widget.timeTable.endTime);
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
                  color: widget.timeTable.subject == "Physics"
                      ? const Color(0xffcd3700)
                      : widget.timeTable.subject == "Biology"
                          ? const Color(0xff03A89E)
                          : widget.timeTable.subject == "Chemistry"
                              ? const Color(0xff4682B4)
                              : const Color(0xffff9912),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 20),
                  ]),
              child: ListTile(
                dense: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Teacher -> ${widget.timeTable.name} (${widget.timeTable.subject})',
                    ),
                    Text(
                      'Grade -> ${widget.timeTable.grade}',
                    ),
                  ],
                ), // Depending on whether a task is complete or incomplete, the widgets will fade or be normal.
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Days: ${widget.timeTable.days.map((day) => day)}',
                      ),
                    ),
                    const Icon(
                      Icons.timer_outlined,
                      size: 14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, top: 1.0),
                      child: Text(
                          '${widget.timeTable.startTime} ~ ${widget.timeTable.endTime}'),
                    ),
                  ],
                ),
                leading: const Icon(
                  Icons.view_timeline_outlined,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: _user!.email != email,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
                color: widget.timeTable.subject == "Physics"
                    ? const Color(0xffcd3700)
                    : widget.timeTable.subject == "Biology"
                        ? const Color(0xff03A89E)
                        : widget.timeTable.subject == "Chemistry"
                            ? const Color(0xff4682B4)
                            : const Color(0xffff9912),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 20),
                ]),
            child: ListTile(
              dense: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Teacher -> ${widget.timeTable.name} (${widget.timeTable.subject})',
                  ),
                  Text(
                    'Grade -> ${widget.timeTable.grade}',
                  ),
                ],
              ), // Depending on whether a task is complete or incomplete, the widgets will fade or be normal.
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Days: ${widget.timeTable.days.map((day) => day)}',
                    ),
                  ),
                  const Icon(
                    Icons.timer_outlined,
                    size: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, top: 1.0),
                    child: Text(
                        '${widget.timeTable.startTime} ~ ${widget.timeTable.endTime}'),
                  ),
                ],
              ),
              leading: const Icon(
                Icons.view_timeline_outlined,
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
