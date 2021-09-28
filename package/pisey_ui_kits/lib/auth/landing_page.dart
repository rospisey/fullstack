part of pisey_ui_kits;

class LandingPage extends StatelessWidget {
  final Widget? child;
  final Widget? emailPage;

  const LandingPage({
    Key? key,
    this.child,
    this.emailPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        onModelReady: (model) {
          model.handleStartUpLogic();
        },
        builder: (context, users, userChild) {
          // return Scaffold(
          //   body: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
          return ViewModelBuilder<StreamUser>.reactive(
              onModelReady: (model) => model.hasUID(),
              disposeViewModel: true,
              builder: (context, streamUser, streamUserChild) {
                if (streamUser.ishasUID!) {
                  return child!;
                } else {
                  if (streamUser.data == null) {
                    // print('${streamUser.data!.uid}');
                    return Row(
                      children: [
                        Flexible(
                            flex: 1,
                            child: SignInPageView(
                              emailPage: emailPage,
                            )),
                        Flexible(
                            flex: getValueForScreenType(
                                context: context,
                                mobile: 0,
                                desktop: 2,
                                tablet: 1,
                                watch: 0),
                            child: Container())
                      ],
                    );
                  }
                  if (!streamUser.data!.emailVerified) {
                    return CheckVerifyEmail();
                  } else {
                    return child!;
                  }
                }
              },
              //       // if (streamUser.data == null) {
              //       //   // print('${streamUser.data!.uid}');
              //       //   return Row(
              //       //     children: [
              //       //       Flexible(
              //       //           flex: 1,
              //       //           child: SignInPageView(
              //       //             emailPage: emailPage,
              //       //           )),
              //       //       Flexible(
              //       //           flex: getValueForScreenType(
              //       //               context: context,
              //       //               mobile: 0,
              //       //               desktop: 2,
              //       //               tablet: 1,
              //       //               watch: 0),
              //       //           child: Container())
              //       //     ],
              //       //   );
              //       // }
              //       // if (!streamUser.data!.emailVerified) {
              //       //   return CheckVerifyEmail();
              //       // } else {
              //       //   return child!;
              //       // }
              //     },
              viewModelBuilder: () => StreamUser());
        },
        viewModelBuilder: () => SignInViewModel());
  }
}
