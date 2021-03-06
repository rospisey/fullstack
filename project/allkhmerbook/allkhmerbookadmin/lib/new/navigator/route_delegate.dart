import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'route_page_manager.dart';
import 'route_path.dart';

class TheAppRouterDelegate extends RouterDelegate<TheAppPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<TheAppPath> {
  TheAppRouterDelegate() {
    // This part is important because we pass the notification
    // from RoutePageManager to RouterDelegate. This way our navigation
    // changes (e.g. pushes) will be reflected in the address bar
    pageManager.init();
    pageManager.addListener(notifyListeners);
    print('init');
  }
  final RoutePageManager pageManager = RoutePageManager();

  /// In the build method we need to return Navigator using [navigatorKey]
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoutePageManager>.value(
      value: pageManager,
      child: Consumer<RoutePageManager>(
        builder: (context, pageManager, child) {
          return Navigator(
            key: navigatorKey,
            // transitionDelegate: NoAnimationTransitionDelegate(),
            onPopPage: _onPopPage,
            pages: List.of(pageManager.pages),
          );
        },
      ),
    );
  }

  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }

    /// Notify the PageManager that page was popped
    pageManager.didPop(route.settings);

    return true;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => pageManager.navigatorKey;

  @override
  TheAppPath get currentConfiguration => pageManager.currentPath;

  @override
  Future<void> setNewRoutePath(TheAppPath configuration) async {
    await pageManager.setNewRoutePath(configuration);
  }
}
