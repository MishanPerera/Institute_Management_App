import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:institute_management_app/reusable_widgets/noticeCard.dart';
import 'package:institute_management_app/screens/notice_screen.dart';

class noticeDisplay extends StatefulWidget {
  const noticeDisplay({super.key});

  @override
  State<noticeDisplay> createState() => _noticeDisplayState();
}

class _noticeDisplayState extends State<noticeDisplay> {
//create the Stream and fetch the all tha data availabe on the notices collection
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("notices").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d1e26),
        // appBar: AppBar(
        //   backgroundColor: Color(0xff1d1e26),
        //   leading: IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () => ZoomDrawer.of(context)!.toggle(),
        //   ),
        //   title: Text(
        //     "Today's Notice",
        //     style: TextStyle(
        //       fontSize: 34,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //     ),
        //   ),
        //   bottom: PreferredSize(
        //     child: Align(
        //       alignment: Alignment.centerLeft,
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 22),
        //         child: Text(
        //           "Monday 21",
        //           style: TextStyle(
        //             fontSize: 33,
        //             fontWeight: FontWeight.w600,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //     preferredSize: Size.fromHeight(35),
        //   ),
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         // Navigate to the add Notice Page
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (builder) => Notice()));
        //       },
        //       tooltip: 'showDailog',
        //       icon: const Icon(Icons.add),
        //     )
        //   ],
        // ),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => ZoomDrawer.of(context)!.toggle()),
          actions: [
            IconButton(
              onPressed: () {
                // Navigate to the add Notice Page
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => Notice()));
              },
              icon: const Icon(Icons.add),
            )
          ],
          title: const Text(
            "Notices",
          ),
        ),
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
                    return NoticeCard(
                      heading: document["heading"],
                      classType: document["classType"],
                      cardColor: cardColor,
                    );
                  });
            }));

    // child: Column(
    //   height: 52,
    //   width: 52,
    //   decoration: BoxDecoration(
    //     shape: BoxShape.circle,
    //     gradient: LinearGradient(
    //       colors: [
    //         Colors.indigoAccent,
    //         Colors.purple,
    //       ],
    //     ),
    //   ),
    //   child: Icon(
    //     Icons.add,
    //     size: 32,
    //     color: Colors.white,
    //   ),
    // ),
  }

  Widget button() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => Notice()));
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 125, 23, 242),
              Color.fromARGB(255, 96, 12, 148),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "ADD NOTICE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
