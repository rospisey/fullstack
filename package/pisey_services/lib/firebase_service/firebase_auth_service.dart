part of pisey_services;

class FirebaseAuthService {
  FirebaseAuthService._();
  static final instance = FirebaseAuthService._();

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();

  Future<UserCredential?> signInWithAnonymously() async {
    try {
      return await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      _dialogService.showDialog(description: '$e');
    }
  }

  Future<void> signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {
      _dialogService.showDialog(description: '$e');
    }
  }

  Future<ActionCodeInfo?> checkActionCode(String code) async {
    try {
      return await FirebaseAuth.instance.checkActionCode(code);
    } catch (e) {
      _dialogService.showDialog(description: '$e');
    }
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    // try {

    // } catch (e) {
    //   _dialogService.showDialog(description: '$e');
    // }
    // ;
    if (kIsWeb) {
      return await FirebaseAuth.instance.setPersistence(Persistence.LOCAL).then(
          (value) => FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password));
    } else {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    }
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

  Future<void> sendEmailVerification(
      [ActionCodeSettings? actionCodeSettings]) async {
    try {
      return await FirebaseAuth.instance.currentUser!
          .sendEmailVerification(actionCodeSettings);
    } catch (e) {
      _dialogService.showDialog(description: '$e');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      var user = await FirebaseAuth.instance.currentUser;
      return user;
    } on FirebaseAuthException catch (e) {
      _dialogService.showDialog(description: '$e');
    }
  }

  static Future<User?> getFirebaseUser() async {
    User? firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      firebaseUser = await FirebaseAuth.instance.authStateChanges().first;
    }
    return firebaseUser;
  }
}
