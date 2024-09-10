import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/components/components.dart';
import 'package:news/cubit/category_cubit.dart';
import 'package:news/cubit/category_states.dart';
import 'package:news/screens/category_screen.dart';
import 'package:news/screens/initial_screen.dart';
import 'package:news/screens/setting_screen.dart';
import 'package:news/widgets/searchs.dart';

class HomesScreen extends StatelessWidget {
  const HomesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => CategoryCubit(),
      child: BlocConsumer<CategoryCubit, CategoryStates>(
        listener: (context, state) {
          // يمكنك إضافة منطق هنا إذا لزم الأمر
        },
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // Custom height
              child: AppBar(
                backgroundColor: Colors.green,
                title: Text(
                  cubit.selectedCategory ?? "News App",
                  style: const TextStyle(color: Colors.white),
                ),
                centerTitle: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(50.0),
                  ),
                ),
                elevation: 0,
                actions: [
                  if (cubit.selectedCategory != null)
                    IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: NewsSearchsDelegate(),
                          );
                        }),
                ],
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
              ),
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              width: screenWidth * 0.7,
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
                      cubit
                          .selectCategory(null); // Use emit to update the state
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
            body: cubit.selectedCategory == null
                ? CategoryScreen(
                    onCategorySelected: (category) {
                      cubit.selectCategory(
                          category); // Pass the selected category
                    },
                  )
                : InitialScreen(
                    category: cubit.selectedCategory!,
                  ),
          );
        },
      ),
    );
  }
}
