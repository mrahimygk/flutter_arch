import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: DrawerItems.values.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return DrawerHeader(
              child: Container(
                height: 240.0,
                color: Colors.green,
              ),
            );
          }
          return ListTile(title: Text(DrawerItems.values[index].toString()));
        },
      ),
    );
  }
}

enum DrawerItems { HEADER, LOGIN, LANGUAGE }
