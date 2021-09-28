part of pisey_services;

class SignInViewModel extends BaseViewModel {
  final FirebaseAuthService _firebaseAuthService =
      StackedLocator.instance.locator<FirebaseAuthService>();
  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();
  final NavigationService _navigationService =
      StackedLocator.instance.locator<NavigationService>();

  Future<UserCredential?> createAccEmail(String email, String password) async {
    try {
      var user = await _firebaseAuthService.createAccountWithEmailAndPassword(
          email, password);
      user!.user!.sendEmailVerification();
      _firebaseAuthService.userFromFirebase(user.user);
      return user;
    } on FirebaseAuthException catch (e) {
      _dialogService.showDialog(
          description: e.message!, title: 'Sign In Failed');
    }
  }

  Future<UserCredential?> signInAccEmail(String email, String password) async {
    try {
      setBusy(true);
      var user = await _firebaseAuthService
          .signInWithEmailAndPassword(email, password)
          .then((value) => handleStartUpLogic());

      // _firebaseAuthService.userFromFirebase(user!.user);
      // await SharedPreferences.getInstance()
      //     .then((value) => value.setString('uid', user!.user!.uid));
      return user;
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
          description: e.message!, title: 'Sign In Failed');
    }
  }

  bool? _ishasUID;
  bool? get ishasUID => _ishasUID;

  Future hasUID() async {
    // await _sharedPreferenceService.getStringUID('uid').then((value) {
    //   _ishasUID = value != null;
    //   notifyListeners();
    // });
    // await _firebaseAuthService.getCurrentUser().then((value) {
    //   _ishasUID = value != null;
    //   notifyListeners();
    // });

    await FirebaseAuth.instance.userChanges().first.then((value) {
      if (value != null) {
        _ishasUID = true;
        notifyListeners();
      } else {
        _ishasUID = false;
        notifyListeners();
      }
    });
  }

  handleStartUpLogic() async {
    await FirebaseAuth.instance.userChanges().first.then((value) {
      if (value != null) {
        _ishasUID = true;
        notifyListeners();
      } else {
        _ishasUID = false;
        notifyListeners();
      }
    });
    if (_ishasUID!) {
      // _navigationService.navigateTo('/Homepage');

      await Future.delayed(Duration(seconds: 1), () async {
        await _navigationService.navigateTo('/Homepage')!.catchError((onError) {
          _dialogService.showDialog(
            description: '$error',
          );
        });
      }).catchError((onError) {
        _dialogService.showDialog(
          description: '$error',
        );
      });
      notifyListeners();
    } else {
      // _navigationService.navigateTo('/sign-in-page-view');
      await Future.delayed(Duration(seconds: 1), () async {
        await _navigationService
            .navigateTo('/sign-in-page-view')!
            .catchError((onError) {
          _dialogService.showDialog(
            description: '$error',
          );
        });
      }).catchError((onError) {
        _dialogService.showDialog(
          description: '$error',
        );
      });
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuthService
          .signOut()
          .then((value) => handleStartUpLogic());
    } on FirebaseAuthException catch (e) {
      _dialogService.showDialog(
          description: e.message!, title: 'Sign In Failed');
    }
  }
}
