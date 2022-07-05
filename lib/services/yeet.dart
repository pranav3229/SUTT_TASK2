import 'package:connectivity_plus/connectivity_plus.dart';

import '../screens/logged_in_widget.dart';
import '../screens/loginpage.dart';

Future yeet() async{
  final ConnectivityResult result = await Connectivity().checkConnectivity();

  if (result == ConnectivityResult.wifi) {

    print('Connected to a Wi-Fi network');
    return LoginPage();
  } else if (result == ConnectivityResult.mobile) {
    print('Connected to a mobile network');
    return LoginPage();
  } else {
    print('Not connected to any network');
    return LoggedInWidget();
  }
}