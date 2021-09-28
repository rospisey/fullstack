import 'package:flutter/material.dart';

import 'route_page_manager.dart';
import 'route_path.dart';

class TheAppRouteInformationParser extends RouteInformationParser<TheAppPath> {
  @override
  Future<TheAppPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    return parseRoute(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(TheAppPath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }
    if (path.isAdmin) {
      return RouteInformation(location: '/admin');
    }
    if (path.isHomePage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/details/${path.id}');
    }
    return null;
  }
}
