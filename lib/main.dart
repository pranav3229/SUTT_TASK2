import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_success/screens/homepage_students.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
import 'package:library_success/services/google_sign_in.dart';
import 'package:library_success/screens/homepage.dart';
import 'package:library_success/screens/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:library_success/services/global_variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

        ),
      ),
    );
  }
}
class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
