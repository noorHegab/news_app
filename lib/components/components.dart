import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepPurple,
  double redius = 20.0,
  required dynamic Onpressed,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(redius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: Onpressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );
Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.yellow[400],
    );

// Widget buildComponent(context, cardDecoration,
//         {required VoidCallback function,
//         required String text,
//         required String path}) =>
//     Expanded(
//       child: Container(
//         decoration: cardDecoration,
//         margin: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Card(
//           color: Theme.of(context).cardTheme.color,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           elevation: 10.0,
//           child: Directionality(
//             textDirection: TextDirection.rtl,
//             child: TextButton(
//               onPressed: function,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       height: 40.0,
//                       width: 40.0,
//                       child: ImageIcon(
//                         AssetImage(path),
//                         color: Theme.of(context).iconTheme.color,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5.0,
//                     ),
//                     Text(
//                       text,
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: title != null
          ? Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      actions: actions,
    );

// List<String> search = [];

// void getSearch(String value) {
//   search = [];
//
//   ((value) {
//     search = value.sura['name'];
//   });
// }
