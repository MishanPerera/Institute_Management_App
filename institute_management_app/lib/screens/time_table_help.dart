import 'package:flutter/material.dart';

class TableHelp extends StatelessWidget {
  const TableHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151e3d),
      appBar: AppBar(
        backgroundColor: const Color(0xff191923),
        title: const Text("Help"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    radius: 70,
                    child: Image.asset(
                      'assets/teacher.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      text: 'Welcome to our app!\n\n',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Our app allows specific users to access CRUD operations of the timetable. If you are not of the specified user type, you can still view the timetable, but you cannot modify the existing data. If you are a user and still cannot proceed, please drop an email to\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'insafnilam.2000@gmail.com\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Our UI is attractive, and the data is sorted by subjects and grades. If you want to view only subject-wise filtered data or filtered data by grade, we provide those options as well. We are constantly trying to improve our app to meet the needs and wants of our users. Please provide us with your valuable feedback and support by emailing us at\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'insafnilam.2000@gmail.com\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        TextSpan(
                          text:
                              'To delete a timetable entry, slide it to the right, and to edit the timetable, slide it to the left and use the action bar. If you need further assistance, please do not hesitate to contact us\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Thank you for choosing our app, and have a pleasant day ahead! Stay tuned for more updates',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
