
import 'package:flutter/material.dart';

class PrivateHeader extends StatelessWidget implements PreferredSizeWidget {
  final String sectionName;

  PrivateHeader({required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(sectionName),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Implement burger menu action
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
