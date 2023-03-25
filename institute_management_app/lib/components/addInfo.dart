import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:logger/logger.dart';

class AddInforWidget extends StatefulWidget {
  const AddInforWidget({super.key});

  @override
  State<AddInforWidget> createState() => _AddInforWidgetState();

  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => const AddInforWidget(),
    );
  }
}

class _AddInforWidgetState extends State<AddInforWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff151e3d),
      icon: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(2.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  child: Image.asset(
                    'assets/logo_foreground.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: 'Welcome to Scholor Sphare!\n\n',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'Our app allows specific users to access CRUD operations of the notices. If you are not of the specified user type, you can still view the notices, but you cannot modify the existing data. If you are a user and still cannot proceed, please drop an email to\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: 'kavindu@gmail.com\n\n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
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
    );
  }
}
