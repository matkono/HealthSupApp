import 'dart:async';

import 'package:connectivity/connectivity.dart';

class CheckInternet {
  var connectivity = new Connectivity();
  bool connectivityStatus = true;
  StreamSubscription<ConnectivityResult> subscription;
  
  checkConnection() {
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
    print('oi');
    print(result);
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
        return true;
    } else {
      return false;
    }
  });
  subscription.cancel();
  return false;
  }
}