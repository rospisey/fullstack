import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pisey_services/pisey_services.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

const bool USE_EMULATOR = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await StorageManager.init();
  setupLocator();
  if (USE_EMULATOR) {
    await _connectToEmulator();
  }
  // FirebaseAppCheck.instance
  //     .activate(webRecaptchaSiteKey: '1A087670-BCCC-43D8-A2AA-EF484531BCCC');
  runApp(MyApp());
}

Future _connectToEmulator() async {
  final localHostString = '192.168.43.118';
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(
      host: '$localHostString:8080',
      sslEnabled: false,
      persistenceEnabled: false);
  await FirebaseStorage.instance
      .useEmulator(host: localHostString, port: 9199)
      .catchError((onError) {
    print('FirebaseStorage error : $onError');
  });
  await FirebaseAuth.instance.useEmulator('http://${localHostString}:9099');
  // FirebaseDatabase(
  //     app: Firebase.app(), databaseURL: 'http://${localHostString}:9000');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     Provider<BaseAuth>(
    //       create: (context) => Auth(),
    //     ),
    //     ChangeNotifierProvider<InternetBloc>(
    //       create: (context) => InternetBloc(),
    //     ),
    //     Provider<Database>(create: (context) => FirestoreDatabase()),
    //     Provider<RDatabase>(
    //       create: (context) => RealTimeDatabase(),
    //     ),
    //     Provider<Storage>(
    //       create: (context) => StorageFirebase(),
    //     )
    //     // StreamProvider<List<UserModel>>(
    //     //   initialData: [],
    //     //   create: (context) => StorageManager.firestoreDatabase!.streamUser(),
    //     // ),
    //     // StreamProvider<UserModel>(
    //     //   initialData: UserModel(uid: '', email: '', name: '', urlPhoto: ''),
    //     //   create: (context) =>
    //     //       Provider.of<BaseAuth>(context, listen: false).onAuthStateChange,
    //     // ),
    //   ],
    //   child: buildMaterialApp(context),
    // );
    return buildMaterialApp(context);
  }

  MaterialApp buildMaterialApp(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
      onGenerateRoute: StackedRouter().onGenerateRoute,
      initialRoute: Routes.homeview,
    );
  }
}
