import 'package:allkhmerbookadmin/page/pageview/homepage.dart';
import 'package:pisey_ui_kits/pisey_ui_kits.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart' as stack_service;
import 'package:pisey_services/pisey_services.dart' as pisey_service;

@StackedApp(routes: [
  MaterialRoute(page: LandingPage, initial: true),
  MaterialRoute(page: Homepage),
  MaterialRoute(page: CheckVerifyEmail),
  MaterialRoute(page: SignInPageView),
], dependencies: [
  LazySingleton(classType: stack_service.NavigationService),
  LazySingleton(classType: stack_service.DialogService),
  LazySingleton(classType: stack_service.SnackbarService),
  LazySingleton(classType: stack_service.BottomSheetService),
  LazySingleton(classType: pisey_service.RealTimeService),
  LazySingleton(classType: pisey_service.FirestoreService),
  LazySingleton(classType: pisey_service.FirebaseAuthService),
  LazySingleton(classType: pisey_service.StorageService),
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
