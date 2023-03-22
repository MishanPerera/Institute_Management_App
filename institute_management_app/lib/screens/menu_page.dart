import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:institute_management_app/models/menu_page_model.dart';

import 'package:quickalert/quickalert.dart';

import '../main.dart';

class MenuItems {
  static const timeTable = MenuItem('Time Table', Icons.table_chart_outlined);
  static const notice = MenuItem('Notice', Icons.card_giftcard);
  static const notifications = MenuItem('Notification', Icons.notifications);
  static const help = MenuItem('Help', Icons.help);
  static const aboutUs = MenuItem('About Us', Icons.info_outline);
  static const rateUs = MenuItem('Rate Us', Icons.star_border);

  static const all = <MenuItem>[
    timeTable,
    notice,
    notifications,
    help,
    aboutUs,
    rateUs
  ];
}

class MenuPage extends StatefulWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
              child: Image.asset(
                'assets/student.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(height: 15, child: Text('Joseph Stalin')),
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(flex: 2),
            TextButton.icon(
              style: TextButton.styleFrom(
                  fixedSize: const Size(120, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red),
              icon: const Icon(Icons.logout),
              onPressed: () => handleLogout(),
              label: const Text('Logout'),
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
