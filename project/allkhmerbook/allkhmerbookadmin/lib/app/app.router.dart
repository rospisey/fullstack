// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:allkhmerbookadmin/main.dart';
import 'package:allkhmerbookadmin/page/pageview/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:stacked/stacked.dart';

import '../page/bloc/home/homeview.dart';
import '../page/bloc/second/secondview.dart';

class Routes {
  static const String homeview = '/';
  static const String secondView = '/second-view';
  static const all = <String>{
    homeview,
    secondView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeview, page: Homeview),
    RouteDef(Routes.secondView, page: SecondView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    Homeview: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LandingPage(
          isDataRealTimeDatabase: true,
          child: Homepage(),
          USE_EMULATOR: USE_EMULATOR,
        ),
        settings: data,
      );
    },
    SecondView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SecondView(),
        settings: data,
      );
    },
  };
}
