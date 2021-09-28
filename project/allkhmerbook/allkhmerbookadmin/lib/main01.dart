import 'package:allkhmerbookadmin/navigator/screen/logout_screen.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'main.dart';

// DATA
const List<Map<String, String>> books = [
  {
    'id': '0',
    'title': 'Stranger in a Strange Land',
    'author': 'Robert A. Heinlein',
  },
  {
    'id': '1',
    'title': 'Foundation',
    'author': 'Isaac Asimov',
  },
  {
    'id': '2',
    'title': 'Fahrenheit 451',
    'author': 'Ray Bradbury',
  },
];

const List<Map<String, String>> articles = [
  {
    'id': '0',
    'title': 'Explaining Flutter Nav 2.0 and Beamer',
    'author': 'Toby Lewis',
  },
  {
    'id': '1',
    'title': 'Flutter Navigator 2.0 for mobile dev: 101',
    'author': 'Lulupointu',
  },
  {
    'id': '2',
    'title': 'Flutter: An Easy and Pragmatic Approach to Navigator 2.0',
    'author': 'Marco Muccinelli',
  },
];

// SCREENS
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.initialIndex, this.book}) : super(key: key);
  final Map<String, String>? book;
  final int? initialIndex;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null) {
      _currentIndex = widget.initialIndex!;
    }
  }

  List page = ['Books', 'Articles'];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IndexCheck>.reactive(
        onModelReady: (model) => model.onModelReady(widget.book),
        builder: (context, model, child) {
          return Scaffold(
            body: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: page.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: _currentIndex == index
                                        ? MaterialStateProperty.all(
                                            Colors.amber)
                                        : MaterialStateProperty.all(
                                            Colors.white),
                                  ),
                                  child: Text('${page[index]}'),
                                  onPressed: () {
                                    Beamer.of(context).update(
                                      // configuration: RouteInformation(
                                      //   location: index == 0 ? '/?tab=books' : '/?tab=articles',
                                      // ),
                                      state: BeamState.fromUriString(
                                          index == 0 ? '/books' : '/articles'),
                                      rebuild: false,
                                    );
                                    model.setbooksIndex(null);

                                    print('${model.booksIndex}');

                                    // context.beamToNamed(
                                    //   index == 0 ? '/books' : '/articles',
                                    // );
                                    // _pageController.jumpToPage(index);
                                    // setState(() => _currentIndex = index);
                                  },
                                ),
                              )
                            ],
                          );
                        })),
                Expanded(
                  flex: 3,
                  child: IndexedStack(
                    index: _currentIndex,
                    children: [
                      BooksScreen(
                        book: widget.book,
                        indexCheck: model,
                      ),
                      ArticlesScreen(),
                      // LoggedInScreen()
                    ],
                  ),
                ),
                // Expanded(
                //   child: PageView(
                //     controller: _pageController,
                //     children: [
                //       BooksScreen(),
                //       ArticlesScreen(),
                //     ],
                //   ),
                //   flex: 3,
                // )
              ],
            ),
            // body: IndexedStack(
            //   index: _currentIndex,
            //   children: [
            //     BooksScreen(),
            //     ArticlesScreen(),
            //   ],
            // ),
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: _currentIndex,
            //   items: [
            //     BottomNavigationBarItem(label: 'Books', icon: Icon(Icons.book)),
            //     BottomNavigationBarItem(label: 'Articles', icon: Icon(Icons.article)),
            //   ],
            //   onTap: (index) {
            //     Beamer.of(context).update(
            //       // configuration: RouteInformation(
            //       //   location: index == 0 ? '/?tab=books' : '/?tab=articles',
            //       // ),
            //       state: BeamState.fromUriString(
            //           index == 0 ? '/?tab=books' : '/?tab=articles'),
            //       rebuild: false,
            //     );
            //     setState(() => _currentIndex = index);
            //   },
            // ),
          );
        },
        viewModelBuilder: () => IndexCheck());
  }
}

class BooksScreen extends StatefulWidget {
  final Map<String, String>? book;
  final IndexCheck? indexCheck;

  BooksScreen({Key? key, required this.book, this.indexCheck})
      : super(
          key: key,
        );

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Books'),
        // ),
        body: Row(
      children: [
        widget.indexCheck!.booksIndex == null
            ? Expanded(
                child: ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              widget.indexCheck!.booksIndex == index
                                  ? MaterialStateProperty.all(Colors.amber)
                                  : MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: () {
                          Beamer.of(context).update(
                            // configuration: RouteInformation(
                            //   location: index == 0 ? '/?tab=books' : '/?tab=articles',
                            // ),
                            state: BeamState.fromUriString('/books/$index'),
                            rebuild: false,
                          );
                          widget.indexCheck!.setbooksIndex(index);
                          // _pageController.jumpToPage(index);
                          // setState(() => _currentIndex = index);
                        },
                        child: Text('${books[index]['title']}'));
                  },
                ),
              )
            : Container(),
        if (widget.indexCheck!.booksIndex != null)
          Expanded(
              child: IndexedStack(
                  index: widget.indexCheck!.booksIndex,
                  children: books.asMap().entries.map((e) {
                    return BookDetailsScreen(book: e.value);
                  }).toList()))
      ],
    ));
  }
}

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({required this.book});
  final Map<String, String> book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(book['title']!),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Author: ${book['author']!}'),
      ),
    );
  }
}

class ArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Articles')),
      body: ListView(
        children: articles
            .map(
              (article) => ListTile(
                title: Text(article['title']!),
                subtitle: Text(article['author']!),
                onTap: () => context.beamToNamed('/articles/${article['id']}'),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({required this.article});
  final Map<String, String> article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Author: ${article['author']!}'),
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
  Future<FirebaseApp> _initialization = Firebase.initializeApp();

  User? _user;
  late final _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = BeamerDelegate(
      // guards: [
      //   BeamGuard(
      //     pathBlueprints: ['/splash', '/'],
      //     check: (context, location) => _user != null,
      //     beamToNamed: '/login',
      //   ),
      //   BeamGuard(
      //     pathBlueprints: ['/splash', '/books/*'],
      //     check: (context, location) => _user != null,
      //     beamToNamed: '/login',
      //   ),
      //   BeamGuard(
      //     pathBlueprints: ['/splash', '/articles/*'],
      //     check: (context, location) => _user != null,
      //     beamToNamed: '/login',
      //   ),
      //   BeamGuard(
      //     pathBlueprints: ['/splash', '/login'],
      //     check: (context, location) => _user == null,
      //     beamToNamed: '/',
      //   ),
      // ],
      initialPath: '/',
      locationBuilder: SimpleLocationBuilder(
        routes: {
          '/': (context, state) {
            // final initialIndex =
            // state.queryParameters['tab'] == 'articles' ? 1 : 0;

            return HomeScreen(
                // initialIndex: initialIndex,
                );
          },
          '/books': (context, state) => HomeScreen(
                initialIndex: 0,
              ),
          '/articles': (context, state) => HomeScreen(initialIndex: 1),
          '/splash': (context, state) => SplashScreen(),
          '/login': (context, state) => LoginScreen(),
          '/books/:bookId': (context, state) {
            final bookId = state.pathParameters['bookId'];

            final book = books.firstWhere((book) => book['id'] == bookId);
            final initialIndex =
                state.queryParameters['tab'] == 'articles' ? 1 : 0;
            return BeamPage(
              key: ValueKey('book-$bookId'),
              title: book['title'],
              child: HomeScreen(initialIndex: initialIndex, book: book),
              // child: BookDetailsScreen(book: book),
              // onPopPage: (context, delegate, page) {
              //   delegate.update(
              //     // configuration: RouteInformation(
              //     //   location: '/?tab=books',
              //     // ),
              //     state: BeamState.fromUriString('/books'),
              //     rebuild: false,
              //   );
              //   return true;
              // },
            );
          },
          'articles/:articleId': (context, state) {
            final articleId = state.pathParameters['articleId'];
            final article =
                articles.firstWhere((article) => article['id'] == articleId);
            return BeamPage(
              key: ValueKey('articles-$articleId'),
              title: article['title'],
              child: ArticleDetailsScreen(article: article),
              // onPopPage: (context, delegate, page) {
              //   delegate.update(
              //     // configuration: RouteInformation(
              //     //   location: '/?tab=articles',
              //     // ),
              //     state: BeamState.fromUriString('/?tab=articles'),
              //     rebuild: false,
              //   );
              //   return true;
              // },
            );
          },
        },
      ),
    );
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
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
    FirebaseAuth.instance
        .userChanges()
        .asBroadcastStream(onCancel: (sub) => sub.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => IndexCheck())],
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: _routerDelegate,
          routeInformationParser: BeamerParser(),
          backButtonDispatcher: BeamerBackButtonDispatcher(
            delegate: _routerDelegate,
          ),
          // builder: (context, child) {
          //   return FutureBuilder(
          //     future: _initialization,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasError) {
          //         return Container(color: Colors.red);
          //       }
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         // this child is the Navigator stack produced by Beamer
          //         return child!;
          //       }
          //       return Scaffold(
          //         body: Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     },
          //   );
          // },
        );
      },
    );
  }
}

void main() => runApp(MyApp());

class IndexCheck extends BaseViewModel {
  int? _booksIndex;

  int? get booksIndex => _booksIndex;

  setbooksIndex(int? booksIndex) {
    _booksIndex = booksIndex;
    notifyListeners();
  }

  onModelReady(Map<String, String>? book) {
    if (book != null) {
      _booksIndex = int.tryParse(book['id']!)!;
      notifyListeners();
    }
  }
}
