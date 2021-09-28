class AppRoutePath {
  final String? page;
  final bool isUnknown;
  final bool? isLogin;

  AppRoutePath.home()
      : page = null,
        isUnknown = false,
        isLogin = true;
  // AppRoutePath.other(this.page)
  //     : isUnknown = false,
  //       isLogin = false;

  AppRoutePath.splash()
      : page = null,
        isUnknown = false,
        isLogin = null;

  AppRoutePath.unknown()
      : page = null,
        isUnknown = true,
        isLogin = false;

  AppRoutePath.login()
      : page = null,
        isUnknown = false,
        isLogin = false;

  bool get isUnknownpage => isUnknown == true;
  bool get isHomepage => isUnknown == false && isLogin == true;
  // bool get isDetailpage => page != null;
  bool get isLoginpage => isUnknown == false && isLogin == false;
  bool get isSplash => isUnknown == false && isLogin == null;
}
