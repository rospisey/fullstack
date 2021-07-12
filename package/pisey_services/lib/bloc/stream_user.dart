part of pisey_services;

class StreamUser extends StreamViewModel<User?> {
  bool? _isVerify;
  bool? get isVerify => _isVerify;

  final DialogService _dialogService =
      StackedLocator.instance.locator<DialogService>();

  Stream<User?> get onAuthStateChange {
    return FirebaseAuth.instance.userChanges();
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
