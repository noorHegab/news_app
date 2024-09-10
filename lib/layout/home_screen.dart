import 'package:flutter/material.dart';
import 'package:news/components/components.dart';
import 'package:news/screens/category_screen.dart';
import 'package:news/screens/initial_screen.dart';
import 'package:news/screens/setting_screen.dart';

import '../widgets/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0), // Custom height
        child: AppBar(
          backgroundColor: Colors.green,
          title: const Text('App with Drawer'),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
          ),
          elevation: 0,
          actions: [
            if (selectedCategory != null)
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NewsSearchDelegate(),
                    );
                  }),
          ],
        ),
      ),
      drawer: Drawer(
        width: 400.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                "News App",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
                selectedCategory = null;
                setState(() {});
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
      ),
      body: selectedCategory == null
          ? CategoryScreen(
              onCategorySelected: onCategorySelected,
            )
          : InitialScreen(
              category: selectedCategory!,
            ),
    );
  }

  String? selectedCategory;

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
}
