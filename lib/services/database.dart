import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DatabaseService{
  final String uid;
  DatabaseService.withoutUID():uid="" ;
  DatabaseService({required this.uid});
  final CollectionReference booksCollection= FirebaseFirestore.instance.collection('Books');
  Future updateUserData(String title, String author,bool check) async{
    return await booksCollection.doc(uid).set({
      'Book Name':title,
      'Author Name':author,
      'Issued': check,

    });
  }

  Stream<QuerySnapshot>? get books{
    return booksCollection.snapshots();
  }

  // List<Book> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     //print(doc.data);
  //     return Book(
  //         name: doc.data['name'] ?? '',
  //         strength: doc.data['strength'] ?? 0,
  //         sugars: doc.data['sugars'] ?? '0');
  //   }).toList();
  // }
}
