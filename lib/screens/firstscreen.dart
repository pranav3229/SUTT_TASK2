import 'package:flutter/material.dart';

import '../services/userinfo_students_a.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child:Column( children:[Text('All Books',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
        Divider(thickness: 1,),
        SizedBox(height: 550,
          child: UserInformationforstuda(),
        ),
        ],
          ),
      ),
    );
  }
}