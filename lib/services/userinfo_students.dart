import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_success/services/add_data.dart';
import 'package:library_success/services/global_variables.dart';
// import 'package:library_success/services/delete_book.dart';



class UserInformationforstud extends StatefulWidget {
  @override
  _UserInformationforstudState createState() => _UserInformationforstudState();
}

class _UserInformationforstudState extends State<UserInformationforstud> {


  final user= FirebaseAuth.instance.currentUser!;
  // var id= FirebaseFirestore.instance.collection('users')
  var currentUser = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots(includeMetadataChanges: true);


  @override
  Widget build(BuildContext context) {
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
            return SizedBox(height: 100,
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.amber,
                  highlightColor: Colors.blue,
                ),
                child: ListTile(
                    tileColor: Colors.grey,


                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    // children: [

                    title: Text('Book: ${data['Book Name']}'),
                    subtitle: Text('Author:  ${data['Author']}'),




                    onLongPress: (){
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

                            setState(() {
                              global.issue = value!;
                              print('${global.issue}');
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
                              deleteData(document.id);

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
                                child: Text('Issue Book'),
                                onPressed: () {

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
                                    deleteData(document.id);





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
