import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_success/screens/homepage_students.dart';
import 'package:library_success/screens/logged_in_widget.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
// import 'package:library_success/screens/loginpage2.dart';
// import 'package:library_success/screens/root/root.dart';
import 'package:library_success/services/google_sign_in.dart';
import 'package:library_success/screens/homepage.dart';
import 'package:library_success/screens/loginpage.dart';
// import 'package:library_success/services/yeet.dart';
import 'package:provider/provider.dart';
import 'package:library_success/services/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // yeet();
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // if (connectivityResult == ConnectivityResult.mobile) {
  //   // I am connected to a mobile network.
  // } else if (connectivityResult == ConnectivityResult.wifi) {
  //   // I am connected to a wifi network.
  // }


  // final FirebaseAuth _auth = FirebaseAuth. instance;
  //
  // Future<void> _signOut() async {
  // await _auth. signOut();
// }

  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);






  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),
      child: MaterialApp(
        home: LandingPage(
        // home: OurRoot(

        ),
      ),
    );
  }
}
class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Future <LoginPage> _signOut()  async{
    await FirebaseAuth.instance.signOut();
    // final ConnectivityResult result = await Connectivity().checkConnectivity();
    //
    // if (result == ConnectivityResult.wifi) {
    //   print('Connected to a Wi-Fi network');
    // } else if (result == ConnectivityResult.mobile) {
    //   print('Connected to a mobile network');
    // } else {
    //   print('Not connected to any network');
    //   LoggedInWidget();
    // }

    return new LoginPage();
  }


  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if(snapshot.hasError)
          {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
    if(snapshot.connectionState== ConnectionState.done){
      return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges() ,
    builder: (context,snapshot){
      if(global.a==true){
        global.a=false;

        return Homepage();
      }

      if(global.b==true){
        global.b=false;
        return Homepage_stud();
      }

      return LoginPage();

          // if(snapshot.connectionState==ConnectionState.waiting){
          //   return Center(child: CircularProgressIndicator());
          // }
          // if(snapshot.connectionState==ConnectionState.active){
          //   Object? user=snapshot.data;
          //   if(user==null){
          //     return LoginPage();
          //
          //   }else{
          //     return Homepage();
          //
          //   }
          // }
          // if(snapshot.hasData){
          //   return Homepage();
          // }
          return Scaffold(
            body: Center(
              child: Text('Checking Authentication...'),
            ),
          );
        }
      );
    }
    return Scaffold(
      body: Center(
        child: Text('Connecting to the app'),
      ),
    );
    // if(global.a==true){
    //   global.a=false;
    //   return Homepage();
    // }
    // if(global.b==true){
    //   global.b=false;
    //   return Homepage_stud();
    // }
    // return LoginPage();


  });}
// }
// );
// }
// }

}
// check()async{
//   bool result=await InternetConnectionChecker().hasConnection;
//   if(result==true)
//   {
//     print('net present');
//
//   }
//   else
//   {
//     print('net absent');
//
//   }
//

