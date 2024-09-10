import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color color;
  final String imagePath;
  final String text;
  final bool check;
  final VoidCallback onpressed; // تعريف الدالة كـ VoidCallback

  CustomContainer({
    Key? key,
    required this.color,
    required this.imagePath,
    required this.text,
    required this.onpressed, // الدالة المطلوبة
    this.check = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد BorderRadius بناءً على قيمة check
    final borderRadius = check
        ? const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(25),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(0),
          );

    return GestureDetector(
      onTap: onpressed,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        width: 200,
        height: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
