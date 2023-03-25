import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/models/Student.dart';
import 'package:institute_management_app/models/menu_page_model.dart';

import 'package:quickalert/quickalert.dart';

import '../main.dart';

class MenuItems {
  static const timeTable = MenuItem('Time Table', Icons.table_chart_outlined);
  static const notice = MenuItem('Notice', Icons.card_giftcard);
  static const teacher = MenuItem('Teacher', Icons.person);
  static const student = MenuItem('Student', Icons.person_2);
  static const aboutUs = MenuItem('About Us', Icons.info_outline);
  static const rateUs = MenuItem('Rate Us', Icons.star_border);

  static const all = <MenuItem>[
    timeTable,
    notice,
    teacher,
    student,
    aboutUs,
    rateUs
  ];
}

class MenuPage extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;
  // Create an instance of FirebaseAuth
  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  void handleLogout() {
    QuickAlert.show(
        context: context,
        title: 'Do you want to logout?',
        type: QuickAlertType.confirm,
        barrierDismissible: true,
        cancelBtnText: 'No',
        confirmBtnText: 'Yes',
        onConfirmBtnTap: () {
          signOut();
        });
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    navigatorKey.currentState!.pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 25),
            CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              radius: 70,
              child: _user == null
                  ? Image.asset(
                      'assets/student.png',
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      'assets/admin.png',
                      fit: BoxFit.contain,
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 24,
              child: _user == null
                  ? const Text('Guest')
                  : Text(_user?.email ?? 'Guest'),
            ),
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(flex: 2),
            TextButton.icon(
              style: TextButton.styleFrom(
                  fixedSize: const Size(120, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: _user == null ? Colors.green : Colors.red),
              icon: const Icon(Icons.logout),
              onPressed: () => handleLogout(),
              label: _user == null ? const Text('Login') : const Text('Logout'),
            ),
            const Spacer(),
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: widget.currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () {
            widget.onSelectedItem(item);
          },
        ),
      );
}
