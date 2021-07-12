part of pisey_ui_kits;

class LandingPage extends StatelessWidget {
  final Widget? child;
  final Widget? emailPage;
  final bool USE_EMULATOR;
  final bool isDataCloudFirestore;
  final bool isDataRealTimeDatabase;

  const LandingPage({
    Key? key,
    this.child,
    this.emailPage,
    this.USE_EMULATOR = false,
    this.isDataCloudFirestore: true,
    this.isDataRealTimeDatabase: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (context, users, userChild) {
          return ViewModelBuilder<StreamUser>.reactive(
              builder: (context, streamUser, streamUserChild) {
                if (streamUser.data == null && !users.isBusy) {
                  return Row(
                    children: [
                      Flexible(
                          flex: 1,
                          child: SignInPageView(
                            isDataCloudFirestore: isDataCloudFirestore,
                            isDataRealTimeDatabase: isDataRealTimeDatabase,
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
                } else {
                  if (!streamUser.data!.emailVerified && !users.isBusy) {
                    return CheckVerifyEmail();
                  } else {
                    return child!;
                  }
                }
              },
              viewModelBuilder: () => StreamUser());
        },
        viewModelBuilder: () => SignInViewModel());
    //   return ViewModelBuilder<StreamUser>.reactive(
    //       builder: (context, user, userchild) {
    //         if (user.data == null && !user.isBusy) {
    //           return Row(
    //             children: [
    //               Flexible(
    //                   flex: 1,
    //                   child: SignInPageView(
    //                     isDataCloudFirestore: isDataCloudFirestore,
    //                     isDataRealTimeDatabase: isDataRealTimeDatabase,
    //                     emailPage: emailPage,
    //                   )),
    //               Flexible(
    //                   flex: getValueForScreenType(
    //                       context: context,
    //                       mobile: 0,
    //                       desktop: 2,
    //                       tablet: 1,
    //                       watch: 0),
    //                   child: Container())
    //             ],
    //           );
    //         }
    //         if (!user.data!.emailVerified && !user.isBusy) {
    //           return CheckVerifyEmail();
    //         }
    //         return child!;
    //       },
    //       viewModelBuilder: () => StreamUser());
  }
}
