import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

enum DownloadState {
  idle,
  running,
  completed,
  fail,
  cancel,
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var _videos = [
  {
    'name': 'Big Buck Bunny',
    'link':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
  },
  {
    'name': 'Elephant Dream',
    'link':
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  }
];
final _documents = [
  {
    'name': 'Learning Android Studio',
    'link': 'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'
  },
  {
    'name': 'Android Programming Cookbook',
    'link':
        'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'
  },
  {
    'name': 'iOS Programming Guide',
    'link': 'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'
  },
  {
    'name': 'Objective-C Programming (Pre-Course Workbook',
    'link':
        'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'
  },
];
final _images = [
  {
    'name': 'Arches National Park',
    'link':
        'https://upload.wikimedia.org/wikipedia/commons/6/60/The_Organ_at_Arches_National_Park_Utah_Corrected.jpg'
  },
  {
    'name': 'Canyonlands National Park',
    'link':
        'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg'
  },
  {
    'name': 'Death Valley National Park',
    'link':
        'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg'
  },
  {
    'name': 'Gates of the Arctic National Park and Preserve',
    'link':
        'https://upload.wikimedia.org/wikipedia/commons/e/e4/GatesofArctic.jpg'
  }
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // leading: Drawer(),
          elevation: 1,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Colors.indigo,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.search_sharp,
                  color: Colors.indigo,
                ),
                onPressed: () {})
          ],
          title: Text('KnongDai Book',
              style: GoogleFonts.lato(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Colors.grey[50],
          child: ListView(
            children: [
              ListTile(
                tileColor: Colors.white,
                title: Text('Pisey'),
                onTap: () {},
              )
            ],
          ),
        ));
  }
}
