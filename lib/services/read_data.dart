import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:library_success/services/delete_book.dart';



class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
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
                   subtitle: Text('Author: ${data['Author']}'),

                   onLongPress: (){
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
                                       ElevatedButton(
                                           onPressed: (){

                                             Navigator.pop(context);

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
                                           },
                                           child: Text('Delete Book'),
                                       ),


                                       // val();



                                       // check? LoggedInWidget():Refresh(),

                                     ],

                                   ),
                                 ),
                                 Row(
                                   children: [
                                     // check? LoggedInWidget():Refresh(),
                                   ],
                                 )
                               ],
                             ),
                           ),

                           actions: <Widget>[
                             FlatButton(
                               child: Text('CANCEL'),
                               onPressed: () {
                                 Navigator.pop(context);
                               },
                             ),
                             FlatButton(
                               child: Text('OK'),
                               onPressed: () {

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
