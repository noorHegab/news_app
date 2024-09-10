import 'package:flutter/material.dart';
import 'package:news/widgets/category.dart';

class CategoryScreen extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryScreen({Key? key, required this.onCategorySelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pick your category of interest",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              children: [
                CustomContainer(
                  onpressed: () {
                    onCategorySelected("sports");
                  },
                  text: "Sports",
                  color: Colors.red,
                  imagePath: 'assets/images/ball.png',
                ),
                CustomContainer(
                  onpressed: () {
                    onCategorySelected("business");
                  },
                  check: true,
                  text: "Business",
                  color: Colors.blue,
                  imagePath: 'assets/images/bussines.png',
                ),
                CustomContainer(
                  onpressed: () {
                    onCategorySelected("general");
                  },
                  text: "general",
                  color: Colors.green,
                  imagePath: 'assets/images/Politics.png',
                ),
                CustomContainer(
                  onpressed: () {
                    onCategorySelected("health");
                  },
                  check: true,
                  text: "Health",
                  color: Colors.orange,
                  imagePath: 'assets/images/health.png',
                ),
                CustomContainer(
                  onpressed: () {
                    onCategorySelected("entertainment");
                  },
                  text: "entertainment",
                  color: Colors.purple,
                  imagePath: 'assets/images/environment.png',
                ),
                CustomContainer(
                  onpressed: () {
                    onCategorySelected("science");
                  },
                  check: true,
                  text: "Science",
                  color: Colors.cyan,
                  imagePath: 'assets/images/science.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
