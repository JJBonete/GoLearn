import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile(
    ListTileThemeData listTileTheme, {
    Key? key,
    required this.icon,
    required this.title,
    required this.callback,
  }) : super(key: key);

  //THIS IS THE DESIGN FOR THE SETTINGS TILE

  final Icon icon;
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: icon,
          iconColor: const Color.fromARGB(255, 0, 0, 0),
          title: Text(
            title,
          ),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          onTap: callback,
        ),
      ],
    );
  }
}
