// import 'dart:html';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_success/services/add_data.dart';
// import 'package:library_success/services/add_name.dart';
import 'package:library_success/services/global_variables.dart';
// import 'package:library_success/services/delete_book.dart';




class UserInformationforstudissue extends StatefulWidget {
  @override
  _UserInformationforstudissueState createState() => _UserInformationforstudissueState();
}

class _UserInformationforstudissueState extends State<UserInformationforstudissue> {
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference users = FirebaseFirestore.instance.collection('Books issued');
  DocumentReference u=FirebaseFirestore.instance.collection('Books issued').doc();










  final user= FirebaseAuth.instance.currentUser!;
  // var id= FirebaseFirestore.instance.collection('users')
  var currentUser = FirebaseAuth.instance.currentUser;

  // Add()async{
  //   print('hello');
  // }
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Books issued').snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    final String issuename;
    // final user= FirebaseAuth.instance.currentUser!;
    issuename=user.email!;





    // Future<void> addUser() {
    //   final user= FirebaseAuth.instance.currentUser!;
    //   AddUser.issuedto=user.email!;
    //   // Call the user's CollectionReference to add a new user
    //   return users
    //       .add({
    //
    //
    //     'Book Issued To': AddUser.issuedto
    //
    //   })
    //       .then((value) => print("Book Added"))
    //       .catchError((error) => print("Failed to add book: $error"));
    // }
    // final user=FirebaseAuth.instance.currentUser!;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot,) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(

          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            // String docID=snapshot.data!.docs[index].id;
            return SizedBox(height: 80,
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.amber,
                  highlightColor: Colors.blue,
                ),
                child: ListTile(
                    tileColor: Colors.white,






                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    // children: [

                    title: Text('Book: ${data['Book Name']}'),
                    subtitle: Text('Author:  ${data['Author']}\nBook Issued to: ${data['Book Issued To']}'),




                    onTap: (){
                      AddUser.check=false;

                      global.issue=false;


                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(

                            title: Text('Critical Actions'),
                            content: SizedBox(
                              child: Column(
                                children: [


                                  SingleChildScrollView(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Issue Book?',
                                          style: TextStyle(
                                            // fontSize: 40,
                                          ),

                                        ),


                                        // ElevatedButton(
                                        //   onPressed: (){
                                        //
                                        //     Navigator.pop(context);
                                        //
                                        //     Future deleteData(String id) async{
                                        //       try {
                                        //         if (currentUser != null) {
                                        //           print(currentUser!.uid);
                                        //         }
                                        //
                                        //         await  FirebaseFirestore.instance
                                        //             .collection("users")
                                        //             .doc(document.id)
                                        //         // .collection("users")
                                        //         // .doc(document.id)
                                        //             .delete();
                                        //       }catch (e){
                                        //         return false;
                                        //       }
                                        //     }
                                        //     deleteData(document.id);
                                        //   },
                                        //   child: Text('Delete Book'),
                                        // ),


                                        // val();



                                        // check? LoggedInWidget():Refresh(),

                                      ],

                                    ),
                                  ),
                                  Row(
                                      children: [
                                        Checkbox(
                                            checkColor: Colors.black,

                                            value:global.issue,
                                            onChanged:(bool? value) {
                                              print('${global.issue}');
                                              Fluttertoast.showToast(msg: "Book Returned");

                                              setState(() {
                                                global.issue = value!;
                                                print('${global.issue}');
                                                DocumentReference copyFrom = FirebaseFirestore.instance.collection('Books issued').doc(document.id);
                                                DocumentReference copyTo = FirebaseFirestore.instance.collection('users').doc(document.id);
                                                DocumentReference copy1From = FirebaseFirestore.instance.collection('Books issued').doc(document.id);
                                                DocumentReference copy1To = FirebaseFirestore.instance.collection('All Books').doc(document.id);
                                                copy1From.get().then((value) => {
                                                  copy1To.set(value.data()),
                                                  // deleteData(document.id)
                                                });
                                                Future deleteData(String id) async{
                                                  try {
                                                    if (currentUser != null) {
                                                      print(currentUser!.uid);
                                                    }

                                                    await  FirebaseFirestore.instance
                                                        .collection("users")
                                                        .doc(document.id)
                                                    // .collection("users")
                                                    // .doc(document.id)
                                                        .delete();
                                                  }catch (e){
                                                    return false;
                                                  }
                                                }
                                                copyFrom.get().then((value) => {
                                                  copyTo.set(value.data()),
                                                deleteData(document.id)
                                                });



                                              }
                                              );
                                              // if (global.issue == true) {
                                              //   Future deleteData(String id) async {
                                              //     try {
                                              //       if (currentUser != null) {
                                              //         print(currentUser!.uid);
                                              //       }
                                              //
                                              //       await FirebaseFirestore.instance
                                              //           .collection("users")
                                              //           .doc(document.id)
                                              //       // .collection("users")
                                              //       // .doc(document.id)
                                              //           .delete();
                                              //     } catch (e) {
                                              //       return false;
                                              //     }
                                              //   }
                                              //   deleteData(document.id);
                                              //   print('${global.issue}');
                                              // }
                                              Navigator.pop(context);


                                              // child: Text('Delete Book'),
                                            })]),
                                  //         Checkbox(
                                  //         checkColor: Colors.white,
                                  // // fillColor: MaterialStateProperty.resolveWith(getColor),
                                  // value: global.issue,
                                  // onChanged: (bool? value) {
                                  //   setState(() {
                                  //     global.issue = value!;
                                  //   });
                                  //
                                  //
                                  //   // check? LoggedInWidget():Refresh(),
                                  // })],

                                ],
                              ),
                            ),

                            actions: <Widget>[
                              FlatButton(
                                child: Text('CANCEL'),
                                onPressed: ()async {

                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text('Return Book'),
                                onPressed: () {
                                  Fluttertoast.showToast(msg: "Book Returned");

                                  DocumentReference copyFrom = FirebaseFirestore.instance.collection('Books issued').doc(document.id);
                                  DocumentReference copyTo = FirebaseFirestore.instance.collection('users').doc(document.id);
                                  DocumentReference copy1From = FirebaseFirestore.instance.collection('Books issued').doc(document.id);
                                  DocumentReference copy1To = FirebaseFirestore.instance.collection('All Books').doc(document.id);
                                  copy1From.get().then((value) => {
                                    copy1To.set(value.data()),
                                    // deleteData(document.id)
                                  });

                                  Future deleteData(String id) async{
                                    try {
                                      if (currentUser != null) {
                                        print(currentUser!.uid);
                                      }

                                      await  FirebaseFirestore.instance
                                          .collection("Books issued")
                                          .doc(document.id)
                                      // .collection("users")
                                      // .doc(document.id)
                                          .delete();
                                    }catch (e){
                                      return false;
                                    }
                                  }

                                  copyFrom.get().then((value) => {
                                    copyTo.set(value.data()),
                                  deleteData(document.id)
                                  });








                                  Navigator.pop(context);


                                  // Navigator.pop(context);
                                  // print(_textFieldController.text);
                                  // Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                  // ],

                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
