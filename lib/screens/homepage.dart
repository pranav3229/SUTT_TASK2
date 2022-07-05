import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
import 'package:library_success/screens/loginpage.dart';

import '../services/yeet.dart';
import 'logged_in_widget.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  ValueNotifier<bool> isnotLoading = ValueNotifier(false);
  Future <LoginPage> _signOut()  async{
    await FirebaseAuth.instance.signOut();

    return new LoginPage();
  }

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


                  return Center(child: CircularProgressIndicator(color: Colors.black,),);
                }
                if(isnotLoading.value=false){
                  return Center(child:CircularProgressIndicator(color: Colors.black));
                }
                else if(snapshot.hasData)
                  {
                    isnotLoading.value=true;
                    return LoggedInWidget();
                  }
                else if(isnotLoading.value=true){
                  return LoggedInWidget();
                }
                else if(snapshot.hasError){

                  return Center(child: Text('Something went wrong'));
                }
                else{
                  // yeet();

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
