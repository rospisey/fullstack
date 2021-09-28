import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:allkhmerbookadmin/navigator/auth_repository.dart';
import 'package:allkhmerbookadmin/navigator/screen/login_screen.dart';
import 'package:allkhmerbookadmin/new/screen/detail_screen.dart';
import 'package:allkhmerbookadmin/new/screen/main_screen.dart';
import 'package:allkhmerbookadmin/new/screen/unknown_screen.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:provider/provider.dart';
import 'route_path.dart';

class RoutePageManager extends ChangeNotifier {
  static RoutePageManager of(BuildContext context) {
    return Provider.of<RoutePageManager>(context, listen: false);
  }

  List<Page> get pages => List.unmodifiable(_pages);
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final List<Page> _pages = [
    MaterialPage(
        child: MainScreen(), key: const ValueKey('MainScreen'), name: '/'),
  ];

  TheAppPath get currentPath {
    return parseRoute(Uri.parse(_pages.last.name!));
  }

  void didPop(RouteSettings page) {
    _pages.remove(page);
    notifyListeners();
  }

  final AuthRepository authRepository = locator<AuthRepository>();
  bool? _loggedIn;
  bool? get loggedIn => _loggedIn;
  set loggedIn(value) {
    // if (_loggedIn == true && value == false) {
    //   // It is a logout!
    //   // _clear();
    // }
    _loggedIn = value;
    notifyListeners();
  }

  init() async {
    loggedIn = await authRepository.isUserLoggedIn();
    print(loggedIn);
  }

  /// This is where we handle new route information and manage the pages list
  Future<void> setNewRoutePath(TheAppPath configuration) async {
    if (configuration.isUnknown) {
      // Handling 404
      _pages.add(
        MaterialPage(
          child: UnknownScreen(),
          key: UniqueKey(),
          name: '/404',
        ),
      );
    } else if (configuration.isAdmin) {
      if (loggedIn == false) {
        _pages.add(MaterialPage(
            key: UniqueKey(),
            child: LoginScreen(() async {
              loggedIn = true;
            }),
            name: '/admin'));
      }
      // Handling 404
      else {
        _pages.add(MaterialPage(
            key: UniqueKey(), child: MainScreen(), name: 'MainScreen'));
      }
    } else if (configuration.isDetailsPage) {
      // Handling details screens
      _pages.add(
        MaterialPage(
          child: DetailsScreen(id: configuration.id),
          key: UniqueKey(),
          name: '/details/${configuration.id}',
        ),
      );
    } else if (configuration.isHomePage) {
      // Restoring to MainScreen
      _pages.removeWhere(
        (element) => element.key != const ValueKey('MainScreen'),
      );
    }
    notifyListeners();
    return;
  }

  void openDetails() {
    setNewRoutePath(TheAppPath.details(_pages.length));
  }

  void resetToHome() {
    setNewRoutePath(TheAppPath.home());
  }

  void goToAdmin() {
    setNewRoutePath(TheAppPath.admin());
  }

  void goToUnknown() {
    setNewRoutePath(TheAppPath.unknown());
  }

  void addDetailsBelow() {
    _pages.insert(
      _pages.length - 1,
      MaterialPage(
        child: DetailsScreen(id: _pages.length),
        key: UniqueKey(),
        name: '/details/${_pages.length}',
      ),
    );
    notifyListeners();
  }
}

TheAppPath parseRoute(Uri uri) {
  // Handle '/'
  if (uri.pathSegments.isEmpty) {
    return TheAppPath.home();
  }

  if (uri.pathSegments.length == 1) {
    if (uri.pathSegments.first == 'admin') return TheAppPath.admin();
    return TheAppPath.unknown();
  }

  // Handle '/details/:id'
  if (uri.pathSegments.length == 2) {
    if (uri.pathSegments[0] != 'details') return TheAppPath.unknown();
    var remaining = uri.pathSegments[1];
    var id = int.tryParse(remaining);
    if (id == null) return TheAppPath.unknown();
    return TheAppPath.details(id);
  }

  // Handle unknown routes
  return TheAppPath.unknown();
}
