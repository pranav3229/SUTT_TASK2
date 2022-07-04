import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_success/services/global_variables.dart';

class AddUser extends StatelessWidget {
  static final String title='';
 static final String author='';
  static String issuedto='';
  static String docid='';
  static bool   check=false;
  // final bool issue;
  // final bool check;

  // AddUser(this.title, this.author,this.issuedto);//this.check

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user=FirebaseAuth.instance.currentUser!;

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'Book Name': title, // John Doe
        'Author': author,
        'Book Issued To': issuedto,
        'Document ID': title,
        'Issue':check,// Stokes and Sons
        // 'Issue': check // 42
      })
          .then((value) => print("Book Added"))
          .catchError((error) => print("Failed to add book: $error"));
    }

    return ElevatedButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}