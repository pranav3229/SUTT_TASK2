import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
class anb extends StatefulWidget {
  const anb({Key? key}) : super(key: key);

  @override
  State<anb> createState() => _anbState();
}

class _anbState extends State<anb> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      behaviour: RacingLinesBehaviour(
        direction: LineDirection.Ltr,
        numLines: 50,
      ),
      vsync: this,
      child:Center(
        child: Text('Racing Behavior Background',style:TextStyle(fontSize:20,
            fontWeight:FontWeight.w500,fontStyle:FontStyle.italic),),
      ),
    );
  }
}
