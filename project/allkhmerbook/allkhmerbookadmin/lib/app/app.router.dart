// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:stacked/stacked.dart';

import '../page/pageview/homepage.dart';

class Routes {
  static const String landingPage = '/';
  static const String homepage = '/Homepage';
  static const String checkVerifyEmail = '/check-verify-email';
  static const String signInPageView = '/sign-in-page-view';
  static const all = <String>{
    landingPage,
    homepage,
    checkVerifyEmail,
    signInPageView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.landingPage, page: LandingPage),
    RouteDef(Routes.homepage, page: Homepage),
    RouteDef(Routes.checkVerifyEmail, page: CheckVerifyEmail),
    RouteDef(Routes.signInPageView, page: SignInPageView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LandingPage: (data) {
      var args = data.getArgs<LandingPageArguments>(
        orElse: () => LandingPageArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LandingPage(
          key: args.key,
          child: args.child,
          emailPage: args.emailPage,
        ),
        settings: data,
      );
    },
    Homepage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const Homepage(),
        settings: data,
      );
    },
    CheckVerifyEmail: (data) {
      var args = data.getArgs<CheckVerifyEmailArguments>(
        orElse: () => CheckVerifyEmailArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CheckVerifyEmail(
          key: args.key,
          child: args.child,
        ),
        settings: data,
      );
    },
    SignInPageView: (data) {
      var args = data.getArgs<SignInPageViewArguments>(
        orElse: () => SignInPageViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignInPageView(
          key: args.key,
          emailPage: args.emailPage,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LandingPage arguments holder class
class LandingPageArguments {
  final Key? key;
  final Widget? child;
  final Widget? emailPage;
  LandingPageArguments({this.key, this.child, this.emailPage});
}

/// CheckVerifyEmail arguments holder class
class CheckVerifyEmailArguments {
  final Key? key;
  final Widget? child;
  CheckVerifyEmailArguments({this.key, this.child});
}

/// SignInPageView arguments holder class
class SignInPageViewArguments {
  final Key? key;
  final Widget? emailPage;
  SignInPageViewArguments({this.key, this.emailPage});
}
