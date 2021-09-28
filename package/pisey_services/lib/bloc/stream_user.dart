part of pisey_services;

class StreamUser extends StreamViewModel<User?> {
  bool? _ishasUID;
  bool? get ishasUID => _ishasUID;

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();
  final FirebaseAuthService _firebaseAuthService =
      StackedLocator.instance.locator<FirebaseAuthService>();
  final NavigationService _navigationService =
      StackedLocator.instance.locator<NavigationService>();

  Stream<User?> get onAuthStateChange {
    return FirebaseAuth.instance.userChanges();
  }

  final SharedPreferenceService _sharedPreferenceService =
      StackedLocator.instance.locator<SharedPreferenceService>();

  hasUID() async {
    // await _sharedPreferenceService.getStringUID('uid').then((value) {
    //   _ishasUID = value != null;
    //   notifyListeners();
    // });
    // await _firebaseAuthService.getCurrentUser().then((value) {
    //   _ishasUID = value != null;
    //   notifyListeners();
    // });

    await onAuthStateChange.first.then((value) {
      _ishasUID = value != null;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        hasUID();
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      _dialogService.showDialog(
          description: e.message!, title: 'Sign In Failed');
    }
  }

  @override
  Stream<User?> get stream => onAuthStateChange;

  @override
  void onError(error) {
    _dialogService.showDialog(
      description: '$error',
      title: 'User error state',
    );
  }

  @override
  void onData(User? user) async {
    try {
      if (user != null && !user.emailVerified) {
        if (await FirebaseAuth.instance.currentUser != null) {
          await user.reload().catchError((onError) {
            print('Catch error onReload:$onError');
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Catch error FirebaseAuthException : ${e.message}');
    } catch (e) {
      print('Catch error onData : $e');
    }
  }
}
