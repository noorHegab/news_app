import 'package:flutter/material.dart';
import 'package:news/components/components.dart';
import 'package:news/screens/setting_screen.dart';

Widget customDrawer({required String header, required BuildContext context}) =>
    Drawer(
      width: 400.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              header.isNotEmpty ? header : "News App",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            onTap: () {
              // Action for Categories
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              navigateTo(context,
                  const SettingScreen()); // Navigate to Settings screen
            },
          ),
        ],
      ),
    );
