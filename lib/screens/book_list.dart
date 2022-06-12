import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';
class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final books=Provider.of<QuerySnapshot>(context);
    // print(books.docs);
    for(var doc in books.docs){
      print(doc.data());
    }
    return Scaffold();
  }
}
