import 'package:flutter/material.dart';
import 'package:institute_management_app/models/menu_page_model.dart';

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

class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPage(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
            child: Column(
          children: [
            const Spacer(),
            CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              child: Image.asset(
                'assets/student.png',
                fit: BoxFit.contain,
                width: 200,
              ),
            ),
            const Spacer(),
            ...MenuItems.all.map(buildMenuItem).toList(),
            const Spacer(flex: 2),
          ],
        )),
      ),
    );
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () {
            onSelectedItem(item);
          },
        ),
      );
}
