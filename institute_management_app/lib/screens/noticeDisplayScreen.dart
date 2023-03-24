import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/components/addInfo.dart';
import 'package:institute_management_app/reusable_widgets/noticeCard.dart';
import 'package:institute_management_app/screens/addNoticeScreen.dart';
import 'package:institute_management_app/screens/viewSingleNoticeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import '../components/add_dailog.dart';

class noticeDisplay extends StatefulWidget {
  const noticeDisplay({super.key});

  @override
  State<noticeDisplay> createState() => _noticeDisplayState();
}

class _noticeDisplayState extends State<noticeDisplay> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String email = "kavindu@gmail.com";
  User? _user;

  double _opacity = 0.0;
  double _padding = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
        _padding = 8.0;
      });
    });
    _user = _auth.currentUser;
  }

//create the Stream and fetch the all tha data availabe on the notices collection
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("notices").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d1e26),
        appBar: AppBar(
          backgroundColor: Color(0xff2d2041),
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => ZoomDrawer.of(context)!.toggle()),
          actions: [
            Visibility(
              visible: _user!.email == email,
              child: IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Notice(),
                  ),
                ),
                icon: const Icon(Icons.add),
              ),
            ),
            IconButton(
              onPressed: () {
                // Display a dialog on top of the current widget
                AddInforWidget.show(context);
              },
              icon: const Icon(Icons.info),
            )
          ],
          title: const Text(
            "Notices",
          ),
        ),
        // StreamBuilder: whenever something is change on the page it will automatically update the app state
        body: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              //inside the snapshot only we're going to get data
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Color cardColor = Color(0xff2d2041);
                    //map the json data into normal dart objects and accessing into the data one by one
                    Map<String, dynamic> document = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    switch (document["classType"]) {
                      case "Biology":
                        cardColor = Color(0xffff6d6e);
                        break;
                      case "Chemistry":
                        cardColor = Color(0xFF3CCC46);
                        break;
                      case "Physics":
                        cardColor = Color(0xFFE28B44);
                        break;
                      default:
                        cardColor = Color(0xff2d2041);
                    }
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ViewNotice(
                                      document: document,
                                      id: snapshot.data!.docs[index].id,
                                    )));
                      },
                      child: NoticeCard(
                        heading: document["heading"],
                        classType: document["classType"],
                        cardColor: cardColor,
                      ),
                    );
                  });
            }));
  }
}
