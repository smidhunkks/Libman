import 'package:flutter/material.dart';

void main()=> runApp(MaterialApp(home:Homepage(),));

class Homepage extends StatefulWidget {
  
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.blue,
        title: Text('Sign In Page'),
      ),

    );
  }
}

