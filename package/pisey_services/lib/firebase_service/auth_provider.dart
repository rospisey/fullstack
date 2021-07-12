part of pisey_services;

abstract class BaseAuth {
  Stream<UserModel> get onAuthStateChange;
  Future<UserModel> signInWithAnonymously();
  UserModel currentUser();
  Future<void> signOut();
  Future<UserModel> signInWithEmailAndPassword(String email, String password);
  Future<UserModel> createAccountWithEmailAndPassword(
      String email, String password);
  // Future<User> signInWithGoogle();
  Future<UserModel> signInWithPhoneNumber(
      String _verificationId, String smsCode);
  Future<UserModel> verifyPhoneNumber(AuthCredential phoneAuthCredential);
  User getCurrentUser();

  Future<void> setUserDataCF(UserModel user);
  Future<void> setUserPresenceRt(UserModel user);
}

class Auth implements BaseAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final instance = FirestoreService.instance;
  final rtInstance = RealTimeService.instance;

  // final GoogleSignIn _googlSignIn = new GoogleSignIn();

  Future<UserModel> signInWithAnonymously() async {
    UserCredential user = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(user.user);
  }

  // Future<User> signInWithGoogle() async {
  //   final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   FirebaseUser user =
  //       (await _firebaseAuth.signInWithCredential(credential)).user;
  //   await setUserData(User(
  //       uid: user.uid,
  //       email: user.email,
  //       name: user.displayName,
  //       urlPhoto: user.photoUrl));
  //   return _userFromFirebase(user);
  // }

  Future<UserModel> signInWithPhoneNumber(
      String _verificationId, String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);
    final User? user =
        (await _firebaseAuth.signInWithCredential(credential)).user;
    return _userFromFirebase(user);
  }

  Future<UserModel> verifyPhoneNumber(
      AuthCredential phoneAuthCredential) async {
    UserCredential user =
        await _firebaseAuth.signInWithCredential(phoneAuthCredential);
    return _userFromFirebase(user.user);
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(user.user);
  }

  @override
  Future<UserModel> createAccountWithEmailAndPassword(
      String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await user.user!.sendEmailVerification();
    return _userFromFirebase(user.user);
  }

  @override
  Future<void> setUserDataCF(UserModel user) async {
    await instance.setData(
        APIpath.setUsersPath(docUserID: user.uid), user.toMapUser());
  }

  UserModel _userFromFirebase(User? user) {
    return UserModel(uid: user!.uid, emailVerified: user.emailVerified);
  }

  @override
  User getCurrentUser() {
    return _firebaseAuth.currentUser!;
  }

  @override
  UserModel currentUser() {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Stream<UserModel> get onAuthStateChange {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserPresenceRt(UserModel user) async {
    await rtInstance.setData('users/${user.uid!}', user.toMapUserPresence());
  }
}
