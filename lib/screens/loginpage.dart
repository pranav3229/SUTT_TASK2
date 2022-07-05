import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_success/main.dart';
import 'package:library_success/screens/homepage.dart';
import 'package:library_success/screens/homepage_students.dart';
import 'package:library_success/screens/logged_in_widget.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
// import 'package:library_success/screens/loginpage2.dart';
import 'package:library_success/screens/student%20login.dart';
import 'package:library_success/services/atoms.dart';
import 'package:library_success/services/database.dart';
import 'package:library_success/services/global_variables.dart';
import 'package:library_success/services/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:animated_background/animated_background.dart';
import 'package:shimmer/shimmer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/post_service.dart';

// import '../services/yeet.dart';
import 'admin_login.dart';
// import 'globals.dart' as globals;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);


  @override
  State<LoginPage> createState() => _LoginPageState();


}

class _LoginPageState extends State<LoginPage>with TickerProviderStateMixin {

  // bool b=false;
  // bool a=false;

  var currentUser = FirebaseAuth.instance.currentUser;


  // late String _uid;
  // late String _emaill;
  // String get getUid =>_uid;
  // String get getEmail =>_emaill;
  // FirebaseAuth _auth=FirebaseAuth.instance;
  // Future<String> onStartUp()async{
  //   String retVal="error";
  //   try{
  //     final _firebaseUser=FirebaseAuth.instance.currentUser!;
  //     _uid=_firebaseUser.uid;
  //     _email=_firebaseUser.email!;
  //     retVal="success";
  //
  //   }catch(e){
  //     print(e);
  //
  //   }
  //   return retVal;
  //
  // }

  final _loginInFormKey= GlobalKey<FormState>();
  Future <LoginPage> _signOut()  async{
    await FirebaseAuth.instance.signOut();

    return new LoginPage();
  }
  Future<void> _createuser()async{
    try{
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      print('UserCredential: $userCredential');
      print('email: $_email');
    }on FirebaseAuthException catch(e){
      print('Error: $e');
    }catch(e){
      print('Error: $e');
    }
  }
  Future<void> getauth()async{
    final username=_email;
    final password=_password;
  }
  Future<void> _login()async{
    try{

      UserCredential userCredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      print('UserCredential: $userCredential');
      print('email: $_email');
      await DatabaseService(uid: userCredential.user!.uid).updateUserData('0', '0', false);
      if (currentUser != null) {
        print(currentUser?.uid);

      }
      
    }on FirebaseAuthException catch(e){
      print('Error: $e');
      // return false;
    }catch(e){

      print('Error: $e');
      // return false;
    }

  }
  // Future<void> _login()async{
  //   try{
  //     UserCredential userCredential=await FirebaseAuth.instance.signInWithCustomToken(username,_password).then((userCredential) => {
  //       const user=userCredential.user;
  //     });
  //     print('UserCredential: $userCredential');
  //     print('email: $_email');
  //   }on FirebaseAuthException catch(e){
  //     print('Error: $e');
  //   }catch(e){
  //     print('Error: $e');
  //   }
  // }
  late String _email;
  late String _password;
  late String username;
  late String usernme;

  @override
  Widget build(BuildContext context) {
    // yeet();

    return DefaultTabController(
      length: 2,
      child: ChangeNotifierProvider(
        create: (context)=>GoogleSignInProvider(),
        child: Form(
          key: _loginInFormKey ,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purpleAccent,
                      onPrimary: Colors.black,
                      // minimumSize: Size(double.infinity,50),
                    ),
                    onPressed: () async {
                      final provider= Provider.of<GoogleSignInProvider>(context,listen:false);
                      provider.logout();
                      await FirebaseAuth.instance.signOut();

                      global.a=false;
                      global.b=false;
                      final ConnectivityResult result = await Connectivity().checkConnectivity();

                      if (result == ConnectivityResult.wifi) {

                        print('Connected to a Wi-Fi network');
                        LoginPage();
                      } else if (result == ConnectivityResult.mobile) {
                        print('Connected to a mobile network');
                        LoginPage();
                      } else {
                        print('Not connected to any network');
                        LoggedInWidget();
                      }

                    },
                    child: Text('Refresh'))
              ],
              backgroundColor: Colors.purple,
              title: Text('Library System'),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.admin_panel_settings_sharp), text:  "Student Signin"),
                  Tab(icon: Icon(Icons.assignment_ind_outlined), text: "Admin Sign in"),
                ],
              ),
            ),

            // resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   backgroundColor: Colors.purple,
            //   title: Text('Login'),
            // ),
            body: TabBarView(
              children: [

                stud(),
                admin(),

          //       behaviour: ChildFlySpaceBehaviour(
          //         // direction: LineDirection.Ltr,
          //         // numLines: 50,
          //       ),
          //
          //         vsync: this,
          //
          //       child: Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: SingleChildScrollView(
          //           child: Column(
          //             // shrinkWrap: true,
          //             // reverse: true,
          //             // mainAxisAlignment: MainAxisAlignment.center,
          //             children: <Widget>[
          //
          //               SizedBox(height:42),
          //               Text(
          //                 'Admin Login',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   fontStyle: FontStyle.italic,
          //                   color: Colors.yellowAccent,
          //                   fontSize: 40.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //
          //               // Text('Admin Login',style: TextStyle(
          //               //   color: Colors.,
          //               //   fontSize: 32,
          //               //   fontWeight: FontWeight.bold,
          //               // ),),
          //               SizedBox(height:35),
          //               Padding(
          //                 padding: const EdgeInsets.all(16.0),
          //                 child: TextField(
          //                   onChanged: (value,){
          //                     _email= '$value@gmail.com';
          //                     username=_email;
          //                     usernme=value;
          //                   },
          //                   decoration: InputDecoration(
          //                     filled:true,
          //                     fillColor: Colors.white,
          //                     hintText: 'Enter Username'
          //                   ),
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(16.0),
          //                 child: TextField(
          //                   obscureText: true,
          //                   onChanged: (value){
          //                     _password=value;
          //                   },
          //                   decoration: InputDecoration(
          //                     filled:true,
          //                       fillColor: Colors.white,
          //                       hintText: 'Enter Password'
          //                   ),
          //                 ),
          //               ),
          //               SizedBox(
          //                 height:28,
          //               ),
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   ElevatedButton(
          //
          //                     style: ElevatedButton.styleFrom(
          //                       fixedSize: Size(124, 36),
          //
          //
          //                       primary: Colors.purple,
          //
          //                     ),
          //                     onPressed: ()async{
          //
          //                       Map<String,dynamic> data={
          //                         "username": usernme,
          //                         "password": _password,
          //                       };
          //
          //                       String res = await PostService().createPost(data);
          //                       res=="Success"? Fluttertoast.showToast(msg: "Post created"):Fluttertoast.showToast(msg: "Logging In");
          //
          //                       void initState() {
          //
          //                       }
          //
          //                       _login();
          //                       global.a=true;
          //                       print('${global.a}');
          //
          //
          //                       // Homepage();
          //                       // if(_login()==true)
          //                       //   {
          //                       //     LoggedInWidget();
          //                       //   }
          //
          //                     },
          //                     child: Text('Login'),
          //                   ),
          //
          //                   // SizedBox(width: 20,),
          //                   // ElevatedButton(
          //                   //   onPressed: (){
          //                   //     _createuser();
          //                   //
          //                   //   },
          //                   //   child: Text('Create New Account'),
          //                   // ),
          //                 ],
          //               ),
          //               SizedBox(height:28),
          //               // Shimmer.fromColors(
          //               //   baseColor: Colors.green,
          //               //   highlightColor: Colors.yellow,
          //               //   child: Divider(
          //               //
          //               //     thickness: 10,
          //               //     indent: 18,
          //               //     endIndent: 18,
          //               //     // height: 350,
          //               //
          //               //   ),
          //               // ),
          //               SizedBox(height:28),
          //               Text(
          //                 'Student Login',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   fontStyle: FontStyle.italic,
          //                   color: Colors.cyanAccent,
          //                   fontSize: 40.0,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               SizedBox(height:90),
          //
          //
          //               ElevatedButton.icon(
          //
          //                 style: ElevatedButton.styleFrom(
          //
          //                   primary: Colors.white,
          //                   onPrimary: Colors.black,
          //                   // minimumSize: Size(double.infinity,50),
          //                 ),
          //                 onPressed: (){
          //
          //                   final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
          //                   provider.googleLogin();
          //
          //                   global.b=true;
          //
          //                   print('${global.b}');
          //                   void initState() {
          //
          //                     Homepage_stud();
          //
          //
          //                   }
          //                   // Homepage_stud;
          //
          //
          //                 },
          //                 icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          //                 label: Text('Sign In with Google'),
          //               )
          //             ]//.reversed.toList(),
          //           ),
          //         ),
          //       ),
          //     ),
          // ],
            ],
            ),
          ),
        ),
      ),
    );
  }
}
