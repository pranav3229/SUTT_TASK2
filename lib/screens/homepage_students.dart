import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
import 'package:library_success/screens/loginpage.dart';
import 'package:library_success/services/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:library_success/services/global_variables.dart';

import 'logged_in_widget.dart';
class Homepage_stud extends StatefulWidget {
  const Homepage_stud({Key? key}) : super(key: key);

  @override
  State<Homepage_stud> createState() => _Homepage_studState();
}

class _Homepage_studState extends State<Homepage_stud> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder:(context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.white,),);
                  }
                  else if(snapshot.hasData)
                  {
                    return LoggedInWidget_stud();
                  }
                  else if(snapshot.hasError){
                    Future logout()async{
                      final provider= Provider.of<GoogleSignInProvider>(context,listen:false);
                      provider.logout();
                      await FirebaseAuth.instance.signOut();
                      global.a=false;
                      global.b=false;
                      print('${global.a} ${global.b}');
                    }
                    logout();
                    return Center(child: Text('Something went wrong'));


                  }

                  else{
                    Future logout()async{
                      final provider= Provider.of<GoogleSignInProvider>(context,listen:false);
                      provider.logout();
                      await FirebaseAuth.instance.signOut();
                      global.a=false;
                      global.b=false;
                      print('${global.a} ${global.b}');
                    }
                    logout();
                    return LoginPage();
                  }
                },
                //
                // child: Center(
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       await FirebaseAuth.instance.signOut();
                //
                //     },
                //     child: Text('SignOut'),
                //   ),
                // ),
              ),
            ),
          ],
        )
    );
  }
}

