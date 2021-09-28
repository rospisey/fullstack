import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

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
    final path = context.currentBeamLocation.state.uri.path;

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
          if (context.currentBeamLocation.state.uri.path.isEmpty)
            Expanded(
              child: Container(
                child: Center(
                  child: Text('Home'),
                ),
              ),
            )
          else
            Expanded(
              child: Beamer(
                key: _beamerKey,
                routerDelegate: BeamerDelegate(
                  locationBuilder: (routeInformation) =>
                      (context.currentBeamLocation.state)
                              .uri
                              .path
                              .contains('articles')
                          ? ArticlesLocation()
                          : BooksLocation(),
                ),
              ),
            ),
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
          Expanded(
            child: Beamer(
              key: _beamerKey,
              routerDelegate: BeamerDelegate(
                locationBuilder: (routeInformation) => BooksContentLocation(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BooksHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books Home'),
      ),
    );
  }
}

class BookAuthorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Authors'),
      ),
    );
  }
}

class BookGenresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Genres'),
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
          Expanded(
            child: Beamer(
              key: _beamerKey,
              routerDelegate: BeamerDelegate(
                locationBuilder: (routeInformation) =>
                    ArticlesContentLocation(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticlesHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Articles Home'),
      ),
    );
  }
}

class ArticleAuthorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Authors'),
      ),
    );
  }
}

class ArticleGenresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Genres'),
      ),
    );
  }
}

class HomeLocation extends BeamLocation<BeamState> {
  HomeLocation() : super();

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('home-${state.uri}'),
            title: 'Home',
            child: HomeScreen(),
            type: BeamPageType.noTransition)
      ];

  @override
  // TODO: implement pathBlueprints
  List get pathBlueprints => ['/*'];
}

class BooksLocation extends BeamLocation<BeamState> {
  BooksLocation() : super();

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('books'),
            title: 'Books',
            child: BooksScreen(),
            type: BeamPageType.noTransition)
      ];

  @override
  // TODO: implement pathBlueprints
  List get pathBlueprints => ['/books/*'];
}

class BooksContentLocation extends BeamLocation<BeamState> {
  BooksContentLocation() : super();

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('books-home'),
            title: 'Books Home',
            child: BooksHomeScreen(),
            type: BeamPageType.noTransition),
        if (state.pathBlueprintSegments.contains('authors'))
          BeamPage(
              key: ValueKey('books-authors'),
              title: 'Books Authors',
              child: BookAuthorsScreen(),
              type: BeamPageType.noTransition),
        if (state.pathBlueprintSegments.contains('genres'))
          BeamPage(
              key: ValueKey('books-genres'),
              title: 'Books Genres',
              child: BookGenresScreen(),
              type: BeamPageType.noTransition)
      ];

  @override
  List get pathBlueprints => [
        '/books/authors',
        '/books/genres',
      ];
}

class ArticlesLocation extends BeamLocation<BeamState> {
  ArticlesLocation() : super();

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('articles'),
            title: 'Articles',
            child: ArticlesScreen(),
            type: BeamPageType.noTransition)
      ];

  @override
  List get pathBlueprints => ['/articles/*'];
}

class ArticlesContentLocation extends BeamLocation<BeamState> {
  ArticlesContentLocation() : super();

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
            key: ValueKey('articles-home'),
            title: 'Articles Home',
            child: ArticlesHomeScreen(),
            type: BeamPageType.noTransition),
        if (state.pathBlueprintSegments.contains('authors'))
          BeamPage(
              key: ValueKey('articles-authors'),
              title: 'Articles Authors',
              child: ArticleAuthorsScreen(),
              type: BeamPageType.noTransition),
        if (state.pathBlueprintSegments.contains('genres'))
          BeamPage(
              key: ValueKey('articles-genres'),
              title: 'Articles Genres',
              child: ArticleGenresScreen(),
              type: BeamPageType.noTransition)
      ];

  @override
  List get pathBlueprints => [
        '/articles/authors',
        '/articles/genres',
      ];
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(beamLocations: [
      HomeLocation(),
      BooksLocation(),
      ArticlesLocation(),
      BooksContentLocation(),
      ArticlesContentLocation(),
    ]),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}
