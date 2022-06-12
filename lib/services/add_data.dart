import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_success/services/global_variables.dart';

class AddUser extends StatelessWidget {
  final String title;
  final String author;
  static bool   check=false;
  // final bool issue;
  // final bool check;

  AddUser(this.title, this.author,);//this.check

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'Book Name': title, // John Doe
        'Author': author,
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