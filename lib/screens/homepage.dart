import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
import 'package:library_success/screens/loginpage.dart';

import 'logged_in_widget.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


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
                  return Center(child: CircularProgressIndicator(),);
                }
                else if(snapshot.hasData)
                  {
                    return LoggedInWidget();
                  }
                else if(snapshot.hasError){
                  return Center(child: Text('Something went wrong'));
                }
                else{
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
