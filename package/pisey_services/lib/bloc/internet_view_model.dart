part of pisey_services;

class InternetViewModel extends StreamViewModel<ConnectivityResult> {
  final bottomsheet = StackedLocator.instance.locator<BottomSheetService>();

  final Connectivity _connectivity = Connectivity();

  ConnectivityResult get result => data ?? ConnectivityResult.none;

  @override
  Stream<ConnectivityResult> get stream => _connectivity.onConnectivityChanged;

  @override
  void onData(ConnectivityResult? data) {
    if (data == ConnectivityResult.none) {
      bottomsheet.showBottomSheet(
          title: 'No connection',
          confirmButtonTitle: 'ok',
          barrierDismissible: false);
    } else {
      bottomsheet.completeSheet(SheetResponse());
    }
  }

  @override
  void onError(error) {
    print('Connection error: $error');
  }

  @override
  void onCancel() {
    super.onCancel();
  }
}
