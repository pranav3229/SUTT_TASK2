import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:library_success/screens/logged_in_widget_students.dart';
class GoogleSignInProvider extends ChangeNotifier{
  var currentUser = FirebaseAuth.instance.currentUser;
  final googleSignIn= GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogin() async{
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,

      );
      if (currentUser != null) {
        print(currentUser!.uid);
      }

      await FirebaseAuth.instance.signInWithCredential(credential);
      notifyListeners();

    }catch(e){
      print(e.toString());
    }

  }
  Future logout()async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}