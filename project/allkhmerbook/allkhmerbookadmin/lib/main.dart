// import 'package:allkhmerbookadmin/app/app.locator.dart';
// import 'package:allkhmerbookadmin/page/pageview/homepage.dart';
// import 'package:bot_toast/bot_toast.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:pisey_services/pisey_services.dart';
// import 'package:stacked_services/stacked_services.dart';

// import 'app/app.router.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// const bool USE_EMULATOR = false;
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();
//   await StorageManager.init();
//   setupLocator();
//   if (USE_EMULATOR) {
//     _connectToEmulator();
//   }

//   //for firebase storage with web, if not error
//   // FirebaseAppCheck.instance
//   //     .activate(webRecaptchaSiteKey: '1A087670-BCCC-43D8-A2AA-EF484531BCCC');
//   runApp(MyApp());
// }

// Future _connectToEmulator() async {
//   final localHostString = 'localhost';

//   await Firebase.initializeApp();
//   FirebaseFirestore.instance.settings = Settings(
//       host: '$localHostString:8080',
//       sslEnabled: false,
//       persistenceEnabled: false);
//   await FirebaseStorage.instance
//       .useStorageEmulator(localHostString, 9190)
//       .catchError((onError) {
//     print('FirebaseStorage error : $onError');
//   });
//   await FirebaseAuth.instance
//       .useAuthEmulator(localHostString, 9198)
//       .catchError((onError) {
//     print('FirebaseStorage error : $onError');
//   });

//   String namespace = '';
//   FirebaseDatabase(
//           app: Firebase.app(),
//           databaseURL: 'http://${localHostString}:9001?ns=$namespace')
//       .reference();
// }

// class MyApp extends StatelessWidget {
//   MyApp({
//     Key? key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return buildMaterialApp(context);
//   }

//   MaterialApp buildMaterialApp(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       navigatorKey: StackedService.navigatorKey,
//       builder: BotToastInit(),
//       navigatorObservers: [
//         StackedService.routeObserver,
//         BotToastNavigatorObserver()
//       ],

//       // home: LandingPage(),
//       onGenerateRoute: StackedRouter().onGenerateRoute,
//       initialRoute: Routes.homepage,
//       // onGenerateInitialRoutes: (String initialRouteName) {
//       //   return [
//       //     StackedRouter().onGenerateRoute(RouteSettings(
//       //         name: Routes.landingPage,
//       //         arguments: LandingPageArguments(
//       //           child: Homepage(),
//       //         )))!
//       //   ];
//       // },
//     );
//   }
// }

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'new/screen/main_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // FirebaseAuth.instance.currentUser!.reload();
              // await FirebaseAuth.instance
              //     .setPersistence(Persistence.LOCAL)
              //     .then((value) async =>
              //         await FirebaseAuth.instance.signInWithEmailAndPassword(
              //           email: "piseykonkhmer123@gmail.com",
              //           password: "11112222",
              //         ));
              FirebaseAuth.instance.signInWithEmailAndPassword(
                email: "piseykonkhmer123@gmail.com",
                password: "11112222",
              );
              // await FirebaseAuth.instance.signInAnonymously();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              } else {
                print(e.message);
              }
            }
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

class LoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async => await FirebaseAuth.instance.signOut(),
          child: Text('Log out'),
        ),
      ),
    );
  }
}

// APP
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _routerDelegate;

  Future<FirebaseApp> _initialization = Firebase.initializeApp();
  User? _user;

  @override
  void initState() {
    super.initState();
    _routerDelegate = BeamerDelegate(
      initialPath: '/splash',
      locationBuilder: SimpleLocationBuilder(
        routes: {
          '/splash': (context, state) => SplashScreen(),
          '/login': (context, state) => LoginScreen(),
          '/loggedin': (context, state) => LoggedInScreen(),
          '/home': (context, state) => HomeScreen(),
          '/books': (context, state) => BooksScreen(),
          '/articles': (context, state) => ArticlesScreen(),
        },
      ),
      guards: [
        BeamGuard(
          pathBlueprints: ['/splash', '/loggedin'],
          check: (context, location) => _user != null,
          beamToNamed: '/login',
        ),
        BeamGuard(
          pathBlueprints: ['/splash', '/home'],
          check: (context, location) => _user != null,
          beamToNamed: '/login',
        ),
        BeamGuard(
          pathBlueprints: ['/splash', '/books'],
          check: (context, location) => _user != null,
          beamToNamed: '/login',
        ),
        BeamGuard(
          pathBlueprints: ['/splash', '/articles'],
          check: (context, location) => _user != null,
          beamToNamed: '/login',
        ),
        BeamGuard(
          pathBlueprints: ['/splash', '/login'],
          check: (context, location) => _user == null,
          beamToNamed: '/loggedin',
        ),
      ],
    );
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() => _user = user);
      } else {
        print('User is signed in!');
        setState(() => _user = user);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeamerProvider(
      routerDelegate: _routerDelegate,
      child: MaterialApp.router(
        routerDelegate: _routerDelegate,
        routeInformationParser: BeamerParser(),
        builder: (context, child) {
          return FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(color: Colors.red);
              }
              if (snapshot.connectionState == ConnectionState.done) {
                // this child is the Navigator stack produced by Beamer
                return child!;
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() => runApp(MyApp());

class MenuButton extends StatefulWidget {
  MenuButton({
    required this.beamer,
    required this.uri,
    required this.child,
  });

  final GlobalKey<BeamerState> beamer;
  final String uri;
  final Widget child;

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  void _setStateListener() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => widget
        .beamer.currentState?.routerDelegate
        .addListener(_setStateListener));
  }

  @override
  Widget build(BuildContext context) {
    final path = (context.currentBeamLocation.state).uri.path;

    return ElevatedButton(
      onPressed: () => Beamer.of(context)
          .currentBeamLocation
          .update((state) => BeamState.fromUriString(widget.uri)),
      style: ButtonStyle(
        backgroundColor: path.contains(widget.uri)
            ? MaterialStateProperty.all<Color>(Colors.green)
            : MaterialStateProperty.all<Color>(Colors.blue),
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    widget.beamer.currentState?.routerDelegate
        .removeListener(_setStateListener);
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue[300],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/books',
                  child: Text('Books'),
                ),
                SizedBox(height: 16.0),
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/articles',
                  child: Text('Articles'),
                ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
        ],
      ),
    );
  }
}

class BooksScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue[300],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/books/authors',
                  child: Text('Book Authors'),
                ),
                SizedBox(height: 16.0),
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/books/genres',
                  child: Text('Book Genres'),
                ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
        ],
      ),
    );
  }
}

class ArticlesScreen extends StatelessWidget {
  final _beamerKey = GlobalKey<BeamerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles'),
      ),
      body: Row(
        children: [
          Container(
            color: Colors.blue[300],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/articles/authors',
                  child: Text('Article Authors'),
                ),
                SizedBox(height: 16.0),
                MenuButton(
                  beamer: _beamerKey,
                  uri: '/articles/genres',
                  child: Text('Article Genres'),
                ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
        ],
      ),
    );
  }
}

class ArticlesLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('articles'),
          title: 'Articles',
          type: BeamPageType.noTransition,
          child: ArticlesScreen(),
        ),
      ];

  @override
  List get pathBlueprints => ['/article'];
}
