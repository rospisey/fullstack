import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(beamLocations: [
      HomeLocation(),
      BooksLocation(),
      ArticlesLocation(),
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
  List get pathBlueprints => ['/*'];
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
  List get pathBlueprints => ['/books'];
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
                // MenuButton(
                //   beamer: _beamerKey,
                //   uri: '/books/authors',
                //   child: Text('Book Authors'),
                // ),
                // SizedBox(height: 16.0),
                // MenuButton(
                //   beamer: _beamerKey,
                //   uri: '/books/genres',
                //   child: Text('Book Genres'),
                // ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
          // Expanded(
          //   child: Beamer(
          //     key: _beamerKey,
          //     routerDelegate: BeamerDelegate(
          //       locationBuilder: (routeInformation) =>
          //           BooksContentLocation(routeInformation),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

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
      onPressed: () => context.beamToNamed(widget.uri),
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
  List get pathBlueprints => ['/articles'];
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
                // MenuButton(
                //   beamer: _beamerKey,
                //   uri: '/articles/authors',
                //   child: Text('Article Authors'),
                // ),
                // SizedBox(height: 16.0),
                // MenuButton(
                //   beamer: _beamerKey,
                //   uri: '/articles/genres',
                //   child: Text('Article Genres'),
                // ),
              ],
            ),
          ),
          Container(width: 1, color: Colors.blue),
          // Expanded(
          //   child: Beamer(
          //     key: _beamerKey,
          //     routerDelegate: BeamerDelegate(
          //       locationBuilder: (routeInformation) =>
          //           ArticlesContentLocation(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
