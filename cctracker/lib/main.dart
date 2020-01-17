import 'package:cctracker/CCList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(CCTracker());

class CCTracker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CC Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: CCList(),
    );
  }

}