import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:library_success/services/add_data.dart';
import 'package:library_success/services/global_variables.dart';
// import 'package:library_success/services/checkbox.dart';
import 'package:library_success/services/google_sign_in.dart';
import 'package:library_success/services/read_data.dart';
import 'package:library_success/services/refresh.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class checkBox extends StatefulWidget {

  late final bool d;
  checkBox(this.d);
  bool check=false;





  @override
  State<checkBox> createState() => _checkBoxState();
}

class _checkBoxState extends State<checkBox> {



  // bool a = false;
  ValueNotifier<bool> a = ValueNotifier(false);




  @override
  Widget build(BuildContext context) {
    return Container(
        child: Checkbox(
            checkColor: Colors.white,
            // fillColor: MaterialStateProperty.resolveWith(getColor),
            value: a.value,
            onChanged: (bool? value) {
              setState(() {
                a.value = value!;
                print('$a');



              });



            }));



  }

  bool val(){
    return a.value;
  }
}


class LoggedInWidget extends StatelessWidget{

  TextEditingController ta = TextEditingController();
  TextEditingController tt = TextEditingController();


  final FirebaseAuth firebaseAuth= FirebaseAuth.instance;
  late  String title;
  late  String author;
  // late final bool check;
  bool check=false;
  // LoggedInWidget(this.title, this.author, this.check);
  // late Map data;
  // addData(){
  //   CollectionReference collectionReference= Firestore.instance.collection('data');
  // }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      print('$title');
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'Book Name': title, // John Doe
        'Author': author, // Stokes and Sons
        'Issue': check // 42

      })
          .then((value) => print("Book Added"))
          .catchError((error) => print("Failed to add book: $error"));};

    final user=FirebaseAuth.instance.currentUser!;
    // Future<checkBox> czec()async{
    //   return checkBox(check);
    //
    // }
    Future<void> _displayTextInputDialog() async {//BuildContext context
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(

            title: Text('Add Books'),
            content: SizedBox(
              child: Column(
                children: [
                  TextField(

                    controller: tt,
                    decoration: InputDecoration(hintText: "Bookname"),

                  ),
                  TextField(
                    // onChanged: (value){
                    //   // controller:_textFieldController2,
                    //
                    //
                    //   author=value;
                    // },
                    controller: ta,
                    decoration: InputDecoration(hintText: "author"),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      children: [

                        // checkBox(check),
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
                  check=true;
                  Navigator.pop(context);
                  title=tt.text;
                  author=ta.text;
                  addUser();
                  tt.clear();
                  ta.clear();


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
    // return Container();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Library System'),
        centerTitle: true,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                onPrimary: Colors.black,
                // minimumSize: Size(double.infinity,50),
              ),
              onPressed: () async {
                final provider= Provider.of<GoogleSignInProvider>(context,listen:false);
                provider.logout();
                await FirebaseAuth.instance.signOut();

                global.a=false;
                global.b=false;

          },
              child: Text('Logout'))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(onPressed:_displayTextInputDialog, child: Text('Add Book')),
              SizedBox(height: 40,),
              Text('Books Available',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
              Divider(),

              SizedBox(height: 300,
                child: UserInformation(),
              )
            ],
          ),
        ),
      ),
    );

  }



}