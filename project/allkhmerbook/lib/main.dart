import 'package:allkhmerbook/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import 'auth/service/auth_provider.dart';
import 'auth/service/database_provider.dart';
import 'auth/service/storage_manager.dart';
import 'package:firebase_core/firebase_core.dart';

const debug = true;
void main() async {
  // HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  await Firebase.initializeApp();
  await StorageManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<BaseAuth>(
          create: (context) => Auth(),
        ),
        Provider<Database>(create: (context) => FirestoreDatabase()),
        // StreamProvider<List<UserModel>>(
        //   initialData: [],
        //   create: (context) => StorageManager.firestoreDatabase!.streamUser(),
        // ),
        // StreamProvider<UserModel>(
        //   initialData: UserModel(uid: '', email: '', name: '', urlPhoto: ''),
        //   create: (context) =>
        //       Provider.of<BaseAuth>(context, listen: false).onAuthStateChange,
        // ),
      ],
      child: newHome(context),
    );
  }

  MaterialApp newHome(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}
