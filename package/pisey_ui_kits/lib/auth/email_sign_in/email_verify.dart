part of pisey_ui_kits;

class CheckVerifyEmail extends ViewModelWidget<StreamUser> {
  final Widget? child;
  CheckVerifyEmail({
    Key? key,
    this.child,
  }) : super(key: key, reactive: true);

  final FirebaseAuthService _authService =
      StackedLocator.instance.locator<FirebaseAuthService>();

  @override
  Widget build(BuildContext context, StreamUser user) {
    return Scaffold(
        body: ListView(
      children: [
        TextButton(
            onPressed: () async => await _authService.signOut(),
            child: Text('Log out')),
        Center(
          child: Text('please check email to verify'),
        ),
        TextButton(
            onPressed: () async => await user.data!.reload(),
            child: user.isBusy ? CircularProgressIndicator() : Text('Check')),
      ],
    ));
  }
}
