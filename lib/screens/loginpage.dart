import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_success/main.dart';
import 'package:library_success/screens/homepage.dart';
import 'package:library_success/screens/homepage_students.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
import 'package:library_success/services/database.dart';
import 'package:library_success/services/global_variables.dart';
import 'package:library_success/services/google_sign_in.dart';
import 'package:provider/provider.dart';
// import 'globals.dart' as globals;
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // bool b=false;
  // bool a=false;
  var currentUser = FirebaseAuth.instance.currentUser;


  final _loginInFormKey= GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>GoogleSignInProvider(),
      child: Form(
        key: _loginInFormKey ,
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white38,
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                // shrinkWrap: true,
                // reverse: true,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text('Admin Login',style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),),
                  TextField(
                    onChanged: (value,){
                      _email= '$value@gmail.com';
                      username=_email;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Username'
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value){
                      _password=value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Password'
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          void initState() {

                          }

                          _login();
                          global.a=true;
                          print('${global.a}');


                          // Homepage();
                          // if(_login()==true)
                          //   {
                          //     LoggedInWidget();
                          //   }

                        },
                        child: Text('Login'),
                      ),

                      // SizedBox(width: 20,),
                      // ElevatedButton(
                      //   onPressed: (){
                      //     _createuser();
                      //
                      //   },
                      //   child: Text('Create New Account'),
                      // ),
                    ],
                  ),
                  SizedBox(height: 200,child:Divider(
                    thickness: 10,
                    // height: 350,

                  ), ),
                  SizedBox(height: 200,child: Text('Student SignIn',style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),),),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(

                        style: ElevatedButton.styleFrom(

                          primary: Colors.white,
                          onPrimary: Colors.black,
                          // minimumSize: Size(double.infinity,50),
                        ),
                        onPressed: (){

                          final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
                          provider.googleLogin();

                          global.b=true;

                          print('${global.b}');
                          void initState() {

                            Homepage_stud();


                          }
                          // Homepage_stud;


                        },
                        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                        label: Text('Sign In with Google'),
                      ),


                    ],
                  )
                ]//.reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}