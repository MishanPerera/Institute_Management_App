import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../models/Notice.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  TextEditingController _headingController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String classType = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff1d1e26),
            Color(0xff2d2041),
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(CupertinoIcons.arrow_left,
                      color: Colors.white, size: 28)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "New Notice",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    label("Heading"),
                    SizedBox(
                      height: 10,
                    ),
                    heading(),
                    SizedBox(
                      height: 15,
                    ),
                    label("Class"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        className("Biology", 0xffff6d6e),
                        SizedBox(
                          width: 10,
                        ),
                        className("Chemistry", 0xFF3CCC46),
                        SizedBox(
                          width: 10,
                        ),
                        className("Physics", 0xFFE28B44),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    label("Description"),
                    SizedBox(
                      height: 10,
                    ),
                    description(),
                    SizedBox(
                      height: 15,
                    ),
                    label("Category"),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        categoryType("Exam", 0xff2664fa),
                        SizedBox(
                          width: 10,
                        ),
                        categoryType("Holiday", 0xff2bc8d9),
                        SizedBox(
                          width: 10,
                        ),
                        categoryType("Other", 0xff6557ff),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    button(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("notices").add({
          "heading": _headingController.text,
          "classType": classType,
          "description": _descriptionController.text,
          "category": category
        });
        Navigator.pop(context);
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

  Widget categoryType(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: _descriptionController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Description of the Notice",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.5,
            ),
            contentPadding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            )),
      ),
    );
  }

  Widget className(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          classType = label;
        });
      },
      child: Chip(
        backgroundColor: classType == label
            ? Colors.white
            : Color(color), //ternairy operator
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: classType == label ? Color(0xff2d2041) : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget heading() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: _headingController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Notice Heading",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.5,
            ),
            contentPadding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            )),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 0.2,
      ),
    );
  }
}
