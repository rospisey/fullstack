import 'package:flutter/material.dart';

import 'approutepath.dart';

class AppRouteInfoParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.length == 0) {
      return AppRoutePath.home();
    }

    if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      // if (_pages.where((element) => element == first).length > 0) {
      //   return AppRoutePath.other('${first}');
      // } else
      if (first == 'home') {
        return AppRoutePath.home();
      } else if (first == 'login') {
        return AppRoutePath.login();
      } else {
        return AppRoutePath.unknown();
      }
    }
    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isHomepage) {
      return RouteInformation(location: '/home');
    }
    if (path.isSplash) {
      return null;
    }
    if (path.isLogin!) {
      return RouteInformation(location: '/login');
    }
    return null;
  }
}
