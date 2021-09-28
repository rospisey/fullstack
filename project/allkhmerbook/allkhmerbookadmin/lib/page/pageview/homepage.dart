import 'package:allkhmerbookadmin/app/app.locator.dart';
import 'package:allkhmerbookadmin/page/pageview/uploadpage.dart';
import 'package:flutter/material.dart';
import 'package:pisey_services/pisey_services.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'bookspage.dart';
import 'userspage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FirebaseAuthService _authService = locator<FirebaseAuthService>();
  DialogService _dialogService = locator<DialogService>();

  Widget child = Text('Hello');
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        onModelReady: (model) => model.hasUID(),
        createNewModelOnInsert: true,
        fireOnModelReadyOnce: true,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          // if (model.ishasUID!) {
          //   return SafeArea(
          //     child: ScreenTypeLayout(
          //       watch: Scaffold(
          //         body: Container(
          //           child: Text('watch'),
          //         ),
          //       ),
          //       mobile: Scaffold(
          //         appBar: _appBar('admin', model),
          //         body: buildDesktop(),
          //       ),
          //       desktop: Scaffold(
          //         appBar: _appBar('admin', model),
          //         body: buildDesktop(),
          //       ),
          //       tablet: Scaffold(
          //         appBar: _appBar('admin', model),
          //         body: buildDesktop(),
          //       ),
          //     ),
          //   );
          // } else {
          //   return Scaffold(
          //     body: Center(
          //       child: Text('User Not found'),
          //     ),
          //   );
          // }

          if (model.ishasUID!) {
            return SafeArea(
              child: ScreenTypeLayout(
                watch: Scaffold(
                  body: Container(
                    child: Text('watch'),
                  ),
                ),
                mobile: Scaffold(
                  appBar: _appBar('admin', model),
                  body: buildDesktop(),
                ),
                desktop: Scaffold(
                  appBar: _appBar('admin', model),
                  body: buildDesktop(),
                ),
                tablet: Scaffold(
                  appBar: _appBar('admin', model),
                  body: buildDesktop(),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('home page'),
              ),
            );
          }
        },
        viewModelBuilder: () => SignInViewModel());
  }

  Row buildDesktop() {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: VerticalTabs(
              hasIndicator: false,
              isCloseDrawer: true,
              selectedSvgColor: Colors.white,
              hoverColor: Colors.blue.withOpacity(0.1),
              backgroundColor: Colors.white,
              tabsElevation: 0.5,
              tabsShadowColor: Colors.grey[500]!,
              tabsWidth: 200,
              indicatorColor: Colors.blue[800]!,
              selectedTabBackgroundColor: Colors.blue[400]!,
              tabTextStyle:
                  myDefaultTextStylePtSans(context, color: Colors.black),
              selectedTabTextStyle:
                  myDefaultTextStylePtSans(context, color: Colors.white),
              indicatorWidth: 10,
              disabledChangePageFromContentView: true,
              initialIndex: 0,
              tabHeight: 50,
              changePageDuration: Duration(microseconds: 1),
              pageScrollPhysics: NeverScrollableScrollPhysics(),
              drawerKey: _drawerKey,
              contents: <Widget>[
                Text('Content4'),
                BooksPage(),
                UploadPage(),
                Text('Content4'),
                UsersPage()
              ],
              tabs: <LocalModel>[
                LocalModel(
                  title: 'Dashboard',
                  svg:
                      '<svg viewBox="0.0 0.0 27.0 27.0" ><path transform="translate(-4.5, -4.5)" d="M 4.5 19.5 L 16.5 19.5 L 16.5 4.5 L 4.5 4.5 L 4.5 19.5 Z M 4.5 31.5 L 16.5 31.5 L 16.5 22.5 L 4.5 22.5 L 4.5 31.5 Z M 19.5 31.5 L 31.5 31.5 L 31.5 16.5 L 19.5 16.5 L 19.5 31.5 Z M 19.5 4.5 L 19.5 13.5 L 31.5 13.5 L 31.5 4.5 L 19.5 4.5 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                ),
                LocalModel(
                  title: 'Content',
                  svg:
                      '<svg viewBox="0.0 0.0 27.0 33.0" ><path transform="translate(-4.5, 0.0)" d="M 28.5 3 L 22.22999954223633 3 C 21.60000038146973 1.259999990463257 19.95000076293945 0 18 0 C 16.04999923706055 0 14.39999961853027 1.259999990463257 13.77000045776367 3 L 7.5 3 C 5.849999904632568 3 4.5 4.349999904632568 4.5 6 L 4.5 30 C 4.5 31.64999961853027 5.849999904632568 33 7.5 33 L 28.5 33 C 30.14999961853027 33 31.5 31.64999961853027 31.5 30 L 31.5 6 C 31.5 4.349999904632568 30.14999961853027 3 28.5 3 Z M 18 3 C 18.82500076293945 3 19.5 3.674999952316284 19.5 4.5 C 19.5 5.324999809265137 18.82500076293945 6 18 6 C 17.17499923706055 6 16.5 5.324999809265137 16.5 4.5 C 16.5 3.675000190734863 17.17499923706055 3 18 3 Z M 28.5 30 L 7.5 30 L 7.5 6 L 10.5 6 L 10.5 10.5 L 25.5 10.5 L 25.5 6 L 28.5 6 L 28.5 30 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                ),
                LocalModel(
                    title: 'Upload',
                    svg:
                        '<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30">   <path id="Path_14" data-name="Path 14" d="M31.5,22.5v6a3,3,0,0,1-3,3H7.5a3,3,0,0,1-3-3v-6" transform="translate(-3 -3)" fill="none" stroke="#000" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"/>   <path id="Path_15" data-name="Path 15" d="M25.5,12,18,4.5,10.5,12" transform="translate(-3 -3)" fill="none" stroke="#000" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"/>   <path id="Path_16" data-name="Path 16" d="M18,4.5v18" transform="translate(-3 -3)" fill="none" stroke="#000" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"/> </svg>'),
                LocalModel(
                    title: 'Notification',
                    svg:
                        '<svg xmlns="http://www.w3.org/2000/svg" width="24.75" height="29.25" viewBox="0 0 24.75 29.25">   <path id="Icon_ionic-md-notifications-outline" data-name="Icon ionic-md-notifications-outline" d="M18.07,8.471a10.165,10.165,0,0,1,1.681.315,7.166,7.166,0,0,1,5.462,7.021v8.973l.655.658.548.55H9.584l.548-.55.655-.658V15.806a7.166,7.166,0,0,1,5.462-7.021,12.447,12.447,0,0,1,1.681-.315m.07-5.1a2.15,2.15,0,0,0-2.184,2.194V6.592a9.479,9.479,0,0,0-7.279,9.214V23.85L5.625,26.775v1.462h24.75V26.775L27.463,23.85V15.806a9.479,9.479,0,0,0-7.279-9.214V5.569A2.15,2.15,0,0,0,18,3.375ZM20.912,29.7H15.088a2.912,2.912,0,1,0,5.823,0Z" transform="translate(-5.625 -3.375)"/> </svg>'),
                LocalModel(
                  title: 'User',
                  svg:
                      '<svg xmlns="http://www.w3.org/2000/svg" width="27" height="30" viewBox="0 0 27 30">   <path id="Path_17" data-name="Path 17" d="M30,31.5v-3a6,6,0,0,0-6-6H12a6,6,0,0,0-6,6v3" transform="translate(-4.5 -3)" fill="none" stroke="#000" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"/>   <path id="Path_18" data-name="Path 18" d="M24,10.5a6,6,0,1,1-6-6,6,6,0,0,1,6,6Z" transform="translate(-4.5 -3)" fill="none" stroke="#000" stroke-linecap="round" stroke-linejoin="round" stroke-width="3"/> </svg>',
                ),
              ],
              indicatorSide: IndicatorSide.start,
              isDrawer: checkDeviceType(context) == DeviceScreenType.mobile
                  ? true
                  : false),
        ),
      ],
    );
  }

  PreferredSize? _appBar(ab, SignInViewModel model) {
    return PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          height: 60,
          padding: EdgeInsets.only(
            left: checkDeviceType(context) != DeviceScreenType.mobile ? 20 : 0,
            right: checkDeviceType(context) != DeviceScreenType.mobile ? 20 : 0,
          ),
          decoration: myBoxDecorationOutline(
            borderRadius: 0,
            color: Colors.blue[50],
          ),
          child: Row(
            children: <Widget>[
              if (checkDeviceType(context) == DeviceScreenType.mobile)
                IconButton(
                  icon: Icon(Icons.menu_outlined),
                  onPressed: () {
                    _drawerKey.currentState!.openDrawer();
                  },
                ),

              RichText(
                  text: TextSpan(
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontFamily: 'Muli'),
                      text: "Homepage",
                      children: <TextSpan>[
                    TextSpan(
                        text: ' - Admin',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[800],
                            fontFamily: 'Muli'))
                  ])),
              Spacer(),
// Adobe XD layer: 'Profile' (group)
              // Adobe XD layer: 'Profile' (group)
              Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PsButtonBouncing(
                    onTap: () async {
                      // await _authService.signOut().catchError((onError) {
                      //   print(onError);
                      // }).then((value) {
                      //   model.ishasUID;
                      // });
                      await model.signOut();
                      // var user = await _authService.getCurrentUser();
                      // await _sharedPreferenceService.removeStringUID('uid');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: const AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  // _SignOutButton(),
                  SizedBox(
                    width: 21.0,
                  ),
                  if (checkDeviceType(context) != DeviceScreenType.mobile)
                    SizedBox(
                        width: 108.0,
                        child: Text(
                          'Ros Pisey',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            color: const Color(0xde000000),
                            letterSpacing: 0.18,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.left,
                        )),
                  if (checkDeviceType(context) != DeviceScreenType.mobile)
                    SizedBox(
                      width: 21.0,
                    ),
                  if (checkDeviceType(context) != DeviceScreenType.mobile)
                    PsButtonBouncing(
                      borderRadius: 50,
                      onTap: () {},
                      child: SizedBox(
                        width: 20.0,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.elliptical(9999.0, 9999.0)),
                                color: const Color(0xffffffff),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xff707070)),
                              ),
                            ),
                            SvgPicture.string(
                              '<svg viewBox="1258.0 33.0 9.0 8.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 1267.0, 41.0)" d="M 4.5 0 L 9 8 L 0 8 Z" fill="#000000" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ));
  }
}

class _SignOutButton extends ViewModelWidget<SignInViewModel> {
  _SignOutButton(
      // this.thisContext,
      {
    Key? key,
  }) : super(key: key, reactive: true);
  // final BuildContext thisContext;

  @override
  Widget build(BuildContext context, SignInViewModel model) {
    return PsButtonBouncing(
      onTap: () async {
        await model.signOut();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: const AssetImage('assets/images/profile.jpg'),
            fit: BoxFit.cover,
          ),
          border: Border.all(width: 1.0, color: const Color(0xff707070)),
        ),
      ),
    );
  }
}
