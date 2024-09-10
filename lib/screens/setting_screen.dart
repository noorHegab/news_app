import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/notifier.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
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
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          DropdownButtonFormField<Locale>(
            value: EasyLocalization.of(context)!.locale,
            items: const [
              DropdownMenuItem(
                value: Locale('en', ''),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: Locale('ar', ''),
                child: Text(
                  'عربي',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                themeNotifier.setLocale(
                    context, newLocale); // تحديث اللغة و _lang معًا
              }
            },
            decoration: const InputDecoration(
              labelText: "Choose Lang",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
