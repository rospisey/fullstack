import 'package:allkhmerbookadmin/page/bloc/home/homeview.dart';
import 'package:allkhmerbookadmin/page/bloc/second/secondview.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart' as stack_service;
import 'package:pisey_services/pisey_services.dart' as pisey_service;

@StackedApp(routes: [
  MaterialRoute(page: Homeview, initial: true),
  MaterialRoute(page: SecondView)
], dependencies: [
  LazySingleton(classType: stack_service.NavigationService),
  LazySingleton(classType: stack_service.DialogService),
  LazySingleton(classType: stack_service.SnackbarService),
  LazySingleton(classType: stack_service.BottomSheetService),
  LazySingleton(classType: pisey_service.RealTimeService),
  LazySingleton(classType: pisey_service.FirestoreService),
  LazySingleton(classType: pisey_service.FirebaseAuthService),
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
