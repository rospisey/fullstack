part of pisey_services;

class SignInViewModel extends BaseViewModel {
  final FirebaseAuthService _firebaseAuthService =
      StackedLocator.instance.locator<FirebaseAuthService>();
  final DialogService _snackbarService =
      StackedLocator.instance.locator<DialogService>();

  Future<UserCredential?> createAccEmail(String email, String password) async {
    try {
      var user = await _firebaseAuthService.createAccountWithEmailAndPassword(
          email, password);
      await user!.user!.sendEmailVerification();
      _firebaseAuthService.userFromFirebase(user.user);
      return user;
    } on FirebaseAuthException catch (e) {
      _snackbarService.showDialog(
          description: e.message!, title: 'Sign In Failed');
    }
  }

  Future<UserCredential?> signInAccEmail(String email, String password) async {
    try {
      setBusy(true);
      var user = await _firebaseAuthService.signInWithEmailAndPassword(
          email, password);
      _firebaseAuthService.userFromFirebase(user.user);
      return user;
    } on FirebaseAuthException catch (e) {
      setBusy(false);
      _snackbarService.showDialog(
          description: e.message!, title: 'Sign In Failed');
    }
  }
}
