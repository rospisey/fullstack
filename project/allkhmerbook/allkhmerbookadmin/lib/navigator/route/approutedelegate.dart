import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:allkhmerbookadmin/navigator/auth_viewmodel.dart';
import 'package:allkhmerbookadmin/navigator/screen/category_screen.dart';
import 'package:allkhmerbookadmin/navigator/screen/dashboard_screen.dart';
import 'package:allkhmerbookadmin/navigator/screen/login_screen.dart';
import 'package:allkhmerbookadmin/navigator/screen/logout_screen.dart';
import 'package:allkhmerbookadmin/navigator/screen/product_screen.dart';
import 'package:allkhmerbookadmin/navigator/screen/splash_screen.dart';
import 'package:allkhmerbookadmin/navigator/screen/unknown_screen.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../auth_repository.dart';
import 'approutepath.dart';

List<String> _pages = ['dashboard', 'category', 'products'];

class AppRouteDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  final AuthRepository authRepository = locator<AuthRepository>();
  String? _page;

  bool? _show404;
  bool? get show404 => _show404;
  set show404(value) {
    _show404 = value;

    notifyListeners();
  }

  bool? _loggedIn;
  bool? get loggedIn => _loggedIn;
  set loggedIn(value) {
    if (_loggedIn == true && value == false) {
      // It is a logout!
      _clear();
    }
    _loggedIn = value;
    notifyListeners();
  }

  AppRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    loggedIn = await authRepository.isUserLoggedIn();
    print(loggedIn);
  }

  AppRoutePath? get currentConfig {
    if (loggedIn == false) {
      return AppRoutePath.login();
    } else if (loggedIn == null) {
      return AppRoutePath.splash();
    } else if (show404 == true) {
      return AppRoutePath.unknown();
    } else if (_page == null)
      return AppRoutePath.home();
    else {
      return null;
    }
    // } else if (_page == null) {
    //   return AppRoutePath.home();
    // } else {
    //   return AppRoutePath.other(_page);
    // }
  }

  _clear() {
    show404 = null;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
        builder: (context, model, child) {
          List<Page> stack;
          if (show404 == true) {
            stack = _unknownStack;
          } else if (loggedIn == null) {
            stack = _splashStack;
          } else if (loggedIn!) {
            stack = _loggedInStack;
          } else {
            stack = _loggedOutStack;
          }
          return Navigator(
            key: navigatorKey,
            pages: stack,
            onPopPage: (routes, result) {
              if (!routes.didPop(result)) {
                return false;
              }
              // notifyListeners();
              // _page = null;
              // show404 = false;

              return true;
            },
          );
        },
        viewModelBuilder: () => AuthViewModel());
  }

  List<Page> get _splashStack {
    String process;
    if (loggedIn == null) {
      process = 'Checking login state...';
    }
    return [MaterialPage(key: ValueKey('splash'), child: SplashScreen())];
  }

  List<Page> get _unknownStack =>
      [MaterialPage(key: ValueKey('unknown'), child: UnknownScreen())];
  List<Page> get _loggedOutStack => [
        MaterialPage(
            key: ValueKey('login'),
            child: LoginScreen(() async {
              loggedIn = true;
            }))
      ];
  List<Page> get _loggedInStack {
    final onLogout = () async {
      loggedIn = false;
    };
    return [
      MaterialPage(key: ValueKey('logout'), child: LogoutScreen(onLogout))
    ];
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    if (configuration.isUnknown) {
      show404 = true;
      loggedIn = false;
      return;
    }
    if (configuration.isHomepage || configuration.isLoginpage) {
      show404 = false;
      loggedIn = true;
      return;
    } else {
      print(' Could not set new route');
    }
    // if (configuration.page == null) {
    //   _page = _pages[0];
    // } else if (_pages
    //     .map((e) => e.toLowerCase())
    //     .toList()
    //     .contains(configuration.page)) {
    //   _page = configuration.page;
    // } else {
    //   show404 = true;
    //   return;
    // }
  }
}
