// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pisey_ui_kits/pisey_ui_kits.dart';

// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   File? _thumbnail;
//   File? _image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Notifications',
//           style: myDefaultTextStyle(context),
//         ),
//       ),
//       body: Center(
//         child: _image == null
//             ? Text('No Image')
//             : ProgressiveImage(
//                 placeholder: FileImage(_thumbnail!),
//                 thumbnail: FileImage(_thumbnail!),
//                 image: FileImage(_image!),
//                 width: MediaQuery.of(context).size.width,
//                 height: 500),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: () {}),
//     );
//   }
// }
