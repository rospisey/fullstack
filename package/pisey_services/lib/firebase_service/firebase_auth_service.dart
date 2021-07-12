part of pisey_services;

class FirebaseAuthService {
  FirebaseAuthService._();
  static final instance = FirebaseAuthService._();

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();

  Future<UserCredential> signInWithAnonymously() async {
    return await FirebaseAuth.instance.signInAnonymously();
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<ActionCodeInfo?> checkActionCode(String code) async {
    return await FirebaseAuth.instance.checkActionCode(code);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential?> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _dialogService.showDialog(description: '$e');
    }
  }

  UserModel userFromFirebase(User? user) {
    return UserModel(uid: user!.uid, emailVerified: user.emailVerified);
  }
}
