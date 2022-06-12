import 'package:flutter/material.dart';
import 'package:library_success/screens/logged_in_widget.dart';

class Refresh extends StatefulWidget {
  const Refresh({Key? key}) : super(key: key);


  @override
  State<Refresh> createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  void initState() {

  }
  @override
  Widget build(BuildContext context) {

    return LoggedInWidget();
  }
}
